#!/usr/bin/env python3
"""Generate site/achievements.html from data/supravim/achievements.json.

Everything on the page comes from that file — titles, descriptions, icons,
categories and the hidden flag. Nothing is written by hand here, so adding an
achievement to the JSON and re-running build.sh is enough.
"""
import html
import json
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = HERE.parents[1]
DATA = REPO / "data/supravim/achievements.json"

BOLD = re.compile(r"\*\*(.+?)\*\*")


def rich(text):
    """escape, then re-apply the **bold** the descriptions use"""
    return BOLD.sub(r"<b>\1</b>", html.escape(text))


def card(a):
    hidden = bool(a.get("hidden"))
    icon = html.escape(a["icon"])
    if hidden:
        # A hidden achievement contributes nothing but an empty slot: its icon,
        # title and description are never written to the page, so they cannot be
        # recovered from the markup, the DOM or view-source. Only the count of
        # hidden entries per category is public.
        return (
            '<li class="ach locked">'
            '<span class="ico" aria-hidden="true">?</span>'
            '<div class="txt"><h3>Hidden</h3></div></li>'
        )
    return (
        f'<li class="ach">'
        f'<span class="ico">{icon}</span>'
        f'<div class="txt"><h3>{html.escape(a["title"])}</h3>'
        f'<p>{rich(a["desc"])}</p></div></li>'
    )


def main():
    data = json.loads(DATA.read_text(encoding="utf-8"))
    achievements = data["achievements"]
    categories = data["categories"]

    known = {c["id"] for c in categories}
    orphans = [a["id"] for a in achievements if a["cat"] not in known]
    if orphans:
        print(f"!! achievements with unknown category: {orphans}", file=sys.stderr)

    total = len(achievements)
    hidden = sum(1 for a in achievements if a.get("hidden"))

    blocks = []
    for c in categories:
        items = [a for a in achievements if a["cat"] == c["id"]]
        if not items:
            continue
        n_hidden = sum(1 for a in items if a.get("hidden"))
        note = f"{n_hidden} hidden" if n_hidden else "all visible"
        blocks.append(
            f'<section class="cat" id="cat-{c["id"]}" data-cat="{c["id"]}">\n'
            f'  <h2><span class="cat-ico">{html.escape(c["icon"])}</span>'
            f'{html.escape(c["label"])}'
            f'<em>{note}</em><b>{len(items)}</b></h2>\n'
            f'  <ul class="ach-grid">\n    '
            + "\n    ".join(card(a) for a in items)
            + "\n  </ul>\n</section>"
        )

    chips = "".join(
        f'<button type="button" class="chip" data-cat="{c["id"]}">'
        f'<span>{html.escape(c["icon"])}</span>{html.escape(c["label"])}</button>'
        for c in categories
    )

    tpl = (HERE / "achievements_template.html").read_text(encoding="utf-8")
    out = (tpl
           .replace("{{TOTAL}}", str(total))
           .replace("{{HIDDEN}}", str(hidden))
           .replace("{{VISIBLE}}", str(total - hidden))
           .replace("{{NCATS}}", str(len(categories)))
           .replace("{{CHIPS}}", chips)
           .replace("{{BLOCKS}}", "\n\n".join(blocks)))
    print(out)


main()
