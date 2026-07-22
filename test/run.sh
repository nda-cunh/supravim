#!/bin/sh
set -eu

DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
status=0

"$DIR/smoke.sh" || status=1
"$DIR/compile.sh" || status=1

echo
if [ "$status" -eq 0 ]; then
	echo "all suites passed"
else
	echo "some suites failed"
fi

exit "$status"
