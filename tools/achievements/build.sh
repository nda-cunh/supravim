#!/bin/sh
# Rebuild site/achievements.html from data/supravim/achievements.json.
set -e

here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo=$(CDPATH= cd -- "$here/../.." && pwd)

python3 "$here/gen_achievements.py" > "$repo/site/achievements.html"

# hidden achievements must never reach the page — fail the build if one does
python3 "$here/check_no_leak.py"

printf 'site/achievements.html rebuilt from %s achievements\n' \
	"$(python3 -c 'import json,sys; print(len(json.load(open(sys.argv[1]))["achievements"]))' \
		"$repo/data/supravim/achievements.json")"
