#!/usr/bin/env python3
"""Fail if a hidden achievement leaks into the generated page.

Hidden achievements must be unreadable from the site: not in the text, not in an
attribute, not in view-source. Only the per-category count of sealed entries is
public. This runs as part of build.sh so the guarantee cannot regress silently.
"""
import json
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
DATA = REPO / "data/supravim/achievements.json"
PAGE = REPO / "site/achievements.html"

data = json.loads(DATA.read_text(encoding="utf-8"))
page = PAGE.read_text(encoding="utf-8")

hidden = [a for a in data["achievements"] if a.get("hidden")]
visible_icons = {a["icon"] for a in data["achievements"] if not a.get("hidden")}

leaks = []
for a in hidden:
    for field in ("id", "title", "desc"):
        value = a.get(field)
        if value and value in page:
            leaks.append(f"{a['id']}: {field} present in page ({value!r})")
    # an icon only leaks if no visible achievement already uses that emoji
    if a["icon"] not in visible_icons and a["icon"] in page:
        leaks.append(f"{a['id']}: icon {a['icon']} present in page")

if leaks:
    print(f"LEAK: {len(leaks)} hidden achievement(s) exposed in site/achievements.html",
          file=sys.stderr)
    for line in leaks:
        print(f"  {line}", file=sys.stderr)
    sys.exit(1)

print(f"no-leak check passed ({len(hidden)} hidden achievements stay sealed)")
