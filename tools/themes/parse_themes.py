#!/usr/bin/env python3
"""Derive a preview palette for every SupraVim colorscheme.

Source of truth: data/supravim/vim/colors/*.vim
  - `# supra-gui: background=#xxxxxx ...` -> the background the GUI itself uses
  - `hi <Group> ... guifg=#xxxxxx guibg=#xxxxxx` -> everything else

Colorschemes that ship both a light and a dark variant guard them with
`if &background == 'light'`; we keep only the branch matching the supra-gui
background luminance.
"""
import json
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
COLORS = REPO / "data/supravim/vim/colors"

HI = re.compile(r"^\s*hi!?\s+(?:link\s+)?(\w+)\s+(.*)$")
# `fg` and `bg` are Vim keywords meaning "whatever Normal's fg/bg is" — atom uses
# `guibg=fg` for its statusline, so they have to be resolved, not skipped.
GUIFG = re.compile(r"guifg=(#[0-9a-fA-F]{6}|fg\b|bg\b)")
GUIBG = re.compile(r"guibg=(#[0-9a-fA-F]{6}|fg\b|bg\b)")
SUPRAGUI = re.compile(r"^#\s*supra-gui:\s*(.*)$")
IF_LIGHT = re.compile(r"^\s*if\s+&background\s*==\s*'light'")
ELSE_ = re.compile(r"^\s*else\s*$")
ENDIF = re.compile(r"^\s*endif\s*$")


def lum(hexcolor):
    r = int(hexcolor[1:3], 16) / 255
    g = int(hexcolor[3:5], 16) / 255
    b = int(hexcolor[5:7], 16) / 255

    def lin(c):
        return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4

    return 0.2126 * lin(r) + 0.7152 * lin(g) + 0.0722 * lin(b)


def contrast(a, b):
    la, lb = lum(a), lum(b)
    hi, lo = max(la, lb), min(la, lb)
    return (hi + 0.05) / (lo + 0.05)


def parse(path):
    text = path.read_text(encoding="utf-8", errors="replace")
    lines = text.splitlines()

    gui = {}
    for line in lines:
        m = SUPRAGUI.match(line)
        if m:
            for pair in m.group(1).split():
                if "=" in pair:
                    k, v = pair.split("=", 1)
                    gui[k] = v
            break

    bg = gui.get("background")
    if not bg:
        print(f"!! {path.name}: no supra-gui background", file=sys.stderr)
        return None
    is_light = lum(bg) > 0.5

    # walk, tracking whether we're inside the wrong &background branch
    groups = {}
    depth_stack = []  # entries: 'light' | 'dark' | None  (None = plain if)
    skipping = 0
    for line in lines:
        if IF_LIGHT.match(line):
            depth_stack.append("light")
            if not is_light:
                skipping += 1
            continue
        if depth_stack and depth_stack[-1] in ("light", "dark") and ELSE_.match(line):
            # flip the branch
            was = depth_stack[-1]
            now = "dark" if was == "light" else "light"
            if (was == "light") != is_light:
                skipping -= 1
            depth_stack[-1] = now
            if (now == "light") != is_light:
                skipping += 1
            continue
        if re.match(r"^\s*if\b", line):
            depth_stack.append(None)
            continue
        if ENDIF.match(line):
            if depth_stack:
                top = depth_stack.pop()
                if top in ("light", "dark") and (top == "light") != is_light:
                    skipping -= 1
            continue
        if skipping > 0:
            continue
        m = HI.match(line)
        if not m:
            continue
        name, rest = m.group(1), m.group(2)
        fg = GUIFG.search(rest)
        bgm = GUIBG.search(rest)
        entry = groups.setdefault(name, {})
        if fg and "fg" not in entry:
            entry["fg"] = fg.group(1)
        if bgm and "bg" not in entry:
            entry["bg"] = bgm.group(1)

    def pick(*names, default=None):
        for n in names:
            v = groups.get(n, {}).get("fg")
            if v:
                return v
        return default

    normal_fg = pick("Normal", default=gui.get("type_s") or gui.get("scope"))
    fallback_dim = "#808080"

    # supra-gui `background` is the GUI chrome colour; the buffer background is
    # `hi Normal guibg`. Use supra-gui only to pick the light/dark branch above,
    # and to fall back when a scheme leaves Normal's background transparent.
    editor_bg = groups.get("Normal", {}).get("bg") or bg

    theme = {
        "name": path.stem,
        "bg": editor_bg,
        "guibg": bg,
        "fg": normal_fg,
        "comment": pick("Comment", default=fallback_dim),
        "string": pick("String", default=gui.get("text")),
        "number": pick("Number", "Float", "Constant", default=gui.get("integer")),
        "keyword": pick("Keyword", "Statement", "Conditional", default=gui.get("include")),
        "func": pick("Function", default=gui.get("function")),
        "type": pick("Type", "Structure", "Typedef", default=gui.get("typedef")),
        "const": pick("Constant", "Boolean", default=gui.get("stdio")),
        "ident": pick("Identifier", default=normal_fg),
        "preproc": pick("PreProc", "Include", "Define", default=gui.get("include")),
        "linenr": pick("LineNr", default=None),
        "cursorline": groups.get("CursorLine", {}).get("bg"),
        "visual": groups.get("Visual", {}).get("bg"),
        "statusbg": groups.get("StatusLine", {}).get("bg"),
        "statusfg": groups.get("StatusLine", {}).get("fg"),
        "light": is_light,
    }

    # resolve the `fg`/`bg` keywords now that Normal is known
    for key, val in theme.items():
        if val == "fg":
            theme[key] = normal_fg
        elif val == "bg":
            theme[key] = editor_bg

    return theme


def main():
    out = []
    for p in sorted(COLORS.glob("*.vim")):
        t = parse(p)
        if t:
            out.append(t)

    # report gaps + low contrast so nothing ships silently broken
    for t in out:
        missing = [k for k, v in t.items() if v is None]
        if missing:
            print(f"MISSING {t['name']}: {missing}", file=sys.stderr)
        for key in ("fg", "comment", "string", "keyword", "func", "type"):
            if t.get(key):
                c = contrast(t["bg"], t[key])
                if c < 1.8:
                    print(f"LOWCONTRAST {t['name']}.{key} {t[key]} on {t['bg']} = {c:.2f}", file=sys.stderr)
        if t.get("statusbg") and t.get("statusfg"):
            c = contrast(t["statusbg"], t["statusfg"])
            if c < 2.0:
                print(f"UNREADABLE-STATUS {t['name']}: {t['statusfg']} on {t['statusbg']} = {c:.2f}", file=sys.stderr)

    print(json.dumps(out, indent=1))


main()
