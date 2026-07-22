ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
TESTDIR="$ROOT/test"
VIM=${VIM_BIN:-vim}

RED=''
GREEN=''
YELLOW=''
RESET=''
if [ -t 1 ]; then
	RED=$(printf '\033[31m')
	GREEN=$(printf '\033[32m')
	YELLOW=$(printf '\033[33m')
	RESET=$(printf '\033[0m')
fi

pass() { printf '%s  ok%s  %s\n' "$GREEN" "$RESET" "$1"; }
fail() { printf '%sFAIL%s  %s\n' "$RED" "$RESET" "$1"; }
skip() { printf '%sskip%s  %s\n' "$YELLOW" "$RESET" "$1"; }
info() { printf '\n== %s ==\n' "$1"; }

require_vim() {
	if ! command -v "$VIM" >/dev/null 2>&1; then
		echo "vim not found in PATH" >&2
		exit 127
	fi
	version_line=$("$VIM" --version | sed -n 1p)
	case "$version_line" in
	*"Vi IMproved 9"*) ;;
	*)
		echo "vim 9 required, got: $version_line" >&2
		exit 1
		;;
	esac
}

make_sandbox() {
	SANDBOX=$(mktemp -d)
	trap 'rm -rf "$SANDBOX"' EXIT INT TERM
	export HOME="$SANDBOX/home"
	mkdir -p "$HOME"
}

vim_version() {
	sed -n 's/^ *version *: *.\([0-9.]*\).*/\1/p' "$ROOT/meson.build" | sed -n 1p
}

render_vimrc() {
	sed "s/@version@/$(vim_version)/g; s/@name@/supravim/g; s/@description@/supravim/g; s|@localedir@|/usr/share/locale|g" \
		"$ROOT/vimrc.in" > "$1"
}
