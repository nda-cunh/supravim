#!/bin/sh
# Rebuild site/themes.html from the colorschemes in data/supravim/vim/colors/.
# Run this after adding, removing or retuning a theme.
set -e

here=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo=$(CDPATH= cd -- "$here/../.." && pwd)

python3 "$here/parse_themes.py" > "$here/themes.json"
python3 "$here/gen_themes.py"   > "$repo/site/themes.html"

printf 'site/themes.html rebuilt from %s colorschemes\n' \
	"$(python3 -c 'import json,sys; print(len(json.load(open(sys.argv[1]))))' "$here/themes.json")"
