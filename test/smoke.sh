#!/bin/sh
set -eu
. "$(dirname -- "$0")/lib.sh"

require_vim
make_sandbox

cp -r "$ROOT/data/supravim/vim" "$HOME/.vim"
cp -r "$TESTDIR/stubs/autoload/." "$HOME/.vim/autoload/"
mkdir -p "$HOME/.config/supravim" "$HOME/.cache/vim/undo"

VIMRC="$HOME/.vimrc"
render_vimrc "$VIMRC"

ERR="$SANDBOX/stderr.txt"
LOG="$SANDBOX/verbose.log"
status=0

info "startup smoke test"

"$VIM" -N -i NONE -u "$VIMRC" --not-a-term \
	--cmd "source $TESTDIR/stubs/commands.vim" \
	-c 'qa!' </dev/null >/dev/null 2>"$ERR" || true

sed 's/\x1b\[[0-9;?]*[a-zA-Z]//g' "$ERR" | grep -E 'Error detected|E[0-9]+:' | sort -u > "$LOG" || true

if [ -s "$LOG" ]; then
	fail "vimrc raised an uncaught error during startup"
	sed 's/^/        /' "$LOG"
	status=1
else
	pass "vimrc sourced without uncaught error"
fi

info "colorscheme load test"

for c in "$ROOT"/data/supravim/vim/colors/*.vim; do
	name=$(basename "$c" .vim)
	rm -f "$LOG"
	if "$VIM" -es -N -i NONE -u NONE --not-a-term \
		--cmd 'syntax enable' \
		--cmd 'set termguicolors' \
		--cmd "set rtp^=$TESTDIR/stubs,$ROOT/data/supravim/vim" \
		--cmd "set verbosefile=$LOG" \
		-c "colorscheme $name" -c 'qa!' </dev/null >/dev/null 2>&1
	then
		pass "colorscheme $name"
	else
		fail "colorscheme $name"
		sed -n '/Error detected/,$p' "$LOG" | sed 's/^/        /'
		echo
		status=1
	fi
done

exit "$status"
