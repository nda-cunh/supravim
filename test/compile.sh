#!/bin/sh
set -eu
. "$(dirname -- "$0")/lib.sh"

require_vim
make_sandbox

STAGE="$SANDBOX/stage"
mkdir -p "$STAGE"
cp -r "$ROOT/data/supravim/vim" "$STAGE/vim"

LOG="$SANDBOX/verbose.log"
RTP="$TESTDIR/stubs,$STAGE/vim,$STAGE/vim/bundle/supravim,$STAGE/vim/bundle/SupraMenu"

total=0
failed=0
skipped=0

info "vim9script compile check"

cd "$STAGE/vim"
for f in $(find . -type f -name '*.vim' | sed 's|^\./||' | sort); do
	grep -q '^vim9script' "$f" || continue

	if grep -qxF "$f" "$TESTDIR/external-deps.txt"; then
		skipped=$((skipped + 1))
		skip "$f"
		continue
	fi

	total=$((total + 1))
	rm -f "$LOG"
	printf '\ndefcompile\n' >> "$STAGE/vim/$f"

	if "$VIM" -es -N -i NONE -u NONE --not-a-term \
		--cmd 'syntax enable' \
		--cmd "set rtp^=$RTP" \
		--cmd "source $TESTDIR/stubs/commands.vim" \
		--cmd "set verbosefile=$LOG" \
		-c "source $STAGE/vim/$f" -c 'qa!' </dev/null >/dev/null 2>&1
	then
		pass "$f"
	else
		failed=$((failed + 1))
		fail "$f"
		sed -n '/Error detected/,$p' "$LOG" | sed 's/^/        /'
		echo
	fi
done

printf '\n%d compiled, %d failed, %d skipped\n' "$total" "$failed" "$skipped"
[ "$failed" -eq 0 ]
