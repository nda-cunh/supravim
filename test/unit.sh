#!/bin/sh
set -eu
. "$(dirname -- "$0")/lib.sh"

require_vim
make_sandbox

STAGE="$SANDBOX/stage"
mkdir -p "$STAGE"
cp -r "$ROOT/data/supravim/vim" "$STAGE/vim"

RTP="$TESTDIR/stubs,$STAGE/vim,$STAGE/vim/bundle/supravim,$STAGE/vim/bundle/SupraMenu"
REPORT="$SANDBOX/report.txt"
export SUPRAVIM_TEST_REPORT="$REPORT"

total=0
failed=0

info "unit tests"

for t in "$TESTDIR"/unit/t_*.vim; do
	[ -e "$t" ] || continue

	name=$(basename "$t")
	run="$STAGE/vim/$name"
	cat "$t" "$TESTDIR/driver.vim" > "$run"
	rm -f "$REPORT"

	"$VIM" -es -N -i NONE -u NONE --not-a-term \
		--cmd 'syntax enable' \
		--cmd "set rtp^=$RTP" \
		--cmd "source $TESTDIR/stubs/commands.vim" \
		-c "source $run" -c 'qa!' </dev/null >/dev/null 2>&1 || true

	if [ ! -f "$REPORT" ]; then
		failed=$((failed + 1))
		total=$((total + 1))
		fail "$name (le script n'a produit aucun rapport)"
		continue
	fi

	while IFS= read -r line; do
		case "$line" in
		"PASS "*)
			total=$((total + 1))
			pass "${line#PASS }"
			;;
		"FAIL "*)
			total=$((total + 1))
			failed=$((failed + 1))
			fail "${line#FAIL }"
			;;
		*)
			printf '%s\n' "$line"
			;;
		esac
	done < "$REPORT"
done

printf '\n%d tests, %d failed\n' "$total" "$failed"
[ "$failed" -eq 0 ]
