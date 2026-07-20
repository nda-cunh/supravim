#!/usr/bin/env python3

import json
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
GENERATED = os.path.join(HERE, 'translatable-strings.c')
POT = os.path.join(ROOT, 'po', 'supravim.pot')
POTFILES = os.path.join(ROOT, 'po', 'POTFILES')

ACHIEVEMENTS = os.path.join('data', 'supravim', 'achievements.json')
ACHIEVEMENT_FIELDS = (('categories', ('label',)), ('achievements', ('title', 'desc')))

OPTIONS_VALA = os.path.join('src', 'supravim', 'main.vala')
DESCRIPTION = 5
ARG_DESCRIPTION = 6

VIM_SOURCES = ['vimrc.in']
VIM_DIRS = [os.path.join('data', 'supravim', 'vim'), 'plugins_supravim']
LORE = re.compile(r"""\blore\s*:\s*(['"])(.*?)(?<!\\)\1""", re.S)
GROUP = re.compile(r"""RegisterGroup\s*\(\s*(['"])(.*?)(?<!\\)\1\s*,\s*(['"])(.*?)(?<!\\)\3""", re.S)
GETTEXT = re.compile(r"""\bgettext\s*\(\s*(['"])(.*?)(?<!\\)\1\s*,\s*['"]supravim['"]\s*\)""", re.S)

PACKAGE = 'supravim'
VERSION = '6.75'
BUGS_ADDRESS = 'nathan.dacunha.nd@gmail.com'


def read(rel):
    with open(os.path.join(ROOT, rel), encoding='utf-8') as fp:
        return fp.read()


def collect_achievements():
    doc = json.loads(read(ACHIEVEMENTS))
    out = []
    for section, keys in ACHIEVEMENT_FIELDS:
        for entry in doc.get(section, []):
            for key in keys:
                value = entry.get(key, '')
                if value:
                    out.append(('%s.%s' % (entry.get('id', ''), key), value))
    return ACHIEVEMENTS, out


def find_array(text):
    start = text.index('const GLib.OptionEntry[] options = {')
    start = text.index('{', start + len('const GLib.OptionEntry[] options'))
    depth = 0
    for i in range(start, len(text)):
        if text[i] == '{':
            depth += 1
        elif text[i] == '}':
            depth -= 1
            if depth == 0:
                return text[start + 1:i]
    raise SystemExit('unterminated options array in %s' % OPTIONS_VALA)


def scan_braces(body):
    entries = []
    depth = 0
    buf = ''
    quote = None
    i = 0
    while i < len(body):
        c = body[i]
        if quote:
            buf += c
            if c == '\\':
                buf += body[i + 1]
                i += 2
                continue
            if c == quote:
                quote = None
        elif c in '"\'':
            quote = c
            buf += c
        elif c == '{':
            depth += 1
            if depth > 1:
                buf += c
            else:
                buf = ''
        elif c == '}':
            depth -= 1
            if depth == 0:
                entries.append(buf)
                buf = ''
            else:
                buf += c
        elif depth:
            buf += c
        i += 1
    return entries


def split_fields(entry):
    fields = []
    buf = ''
    quote = None
    i = 0
    while i < len(entry):
        c = entry[i]
        if quote:
            buf += c
            if c == '\\':
                buf += entry[i + 1]
                i += 2
                continue
            if c == quote:
                quote = None
        elif c in '"\'':
            quote = c
            buf += c
        elif c == ',':
            fields.append(buf.strip())
            buf = ''
        else:
            buf += c
        i += 1
    fields.append(buf.strip())
    return fields


def collect_options():
    text = read(OPTIONS_VALA)
    out = []
    for entry in scan_braces(find_array(text)):
        fields = split_fields(entry)
        if len(fields) <= ARG_DESCRIPTION:
            continue
        name = re.match(r'^"(.*)"$', fields[0])
        for index in (DESCRIPTION, ARG_DESCRIPTION):
            m = re.match(r'^"(.*)"$', fields[index])
            if m and m.group(1):
                out.append(('--%s' % (name.group(1) if name else ''), m.group(1)))
    return OPTIONS_VALA, out


def vim_files():
    for rel in VIM_SOURCES:
        if os.path.exists(os.path.join(ROOT, rel)):
            yield rel
    for scan in VIM_DIRS:
        for dirpath, _dirs, names in os.walk(os.path.join(ROOT, scan)):
            for name in sorted(names):
                if name.endswith('.vim'):
                    path = os.path.join(dirpath, name)
                    yield os.path.relpath(path, ROOT)


def collect_vim():
    sections = []
    for rel in vim_files():
        text = read(rel)
        found = [m.group(2) for m in LORE.finditer(text)]
        found += [m.group(4) for m in GROUP.finditer(text)]
        found += [m.group(2) for m in GETTEXT.finditer(text)]
        if found:
            sections.append((rel, [('', v.replace("\\'", "'")) for v in found]))
    return sections


def escape(value):
    return value.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\t', '\\t')


def write_generated():
    sections = [collect_achievements(), collect_options()] + collect_vim()

    lines = [
        '/* generate by tools/update-translations.py. */',
        '',
        '#define N_(s) s',
        '',
        'static const char *const translatable_strings[] = {',
    ]
    seen = set()
    total = 0
    for origin, items in sections:
        emitted = False
        for context, value in items:
            if not value or value in seen:
                continue
            seen.add(value)
            if not emitted:
                lines.append('\t/* %s */' % origin)
                emitted = True
            if context:
                lines.append('\t/* %s */' % context)
            lines.append('\tN_("%s"),' % escape(value))
            total += 1
    lines.append('};')
    lines.append('')

    with open(GENERATED, 'w', encoding='utf-8') as fp:
        fp.write('\n'.join(lines))
    return total


def run(cmd):
    result = subprocess.run(cmd, cwd=ROOT)
    if result.returncode != 0:
        raise SystemExit('failed: %s' % ' '.join(cmd))


def main():
    total = write_generated()
    print('%s: %d strings' % (os.path.relpath(GENERATED, ROOT), total))

    run(['xgettext', '--from-code=UTF-8', '--keyword=_', '--keyword=N_',
         '--add-comments', '--package-name=' + PACKAGE, '--package-version=' + VERSION,
         '--msgid-bugs-address=' + BUGS_ADDRESS, '--copyright-holder=SupraVim',
         '--files-from=' + os.path.relpath(POTFILES, ROOT),
         '-o', os.path.relpath(POT, ROOT)])
    print('%s regenerated' % os.path.relpath(POT, ROOT))

    po_dir = os.path.join(ROOT, 'po')
    for name in sorted(os.listdir(po_dir)):
        if not name.endswith('.po'):
            continue
        rel = os.path.join('po', name)
        run(['msgmerge', '--quiet', '--update', '--backup=none', rel,
             os.path.relpath(POT, ROOT)])
        stats = subprocess.run(['msgfmt', '--statistics', '-o', os.devnull, rel],
                               cwd=ROOT, capture_output=True, text=True)
        sys.stdout.write('%s : %s' % (rel, stats.stderr))


if __name__ == '__main__':
    main()
