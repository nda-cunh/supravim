#!/bin/sh

install_supravim() {
	export PATH="$TMPDIR/suprapack:$PWD:$PATH"
	printf '\033[93;1mInstalling supravim...\033[0m\n'
	# if IS42 is true, install plugin-norminette plugin-42formatter
	if [ "$IS42" = "true" ]; then
		suprapack add supravim plugin-norminette plugin-42formatter ccls --force --yes
		printf '\033[92;1mSupravim and 42 plugins installed successfully!\033[0m\n'
	else
		suprapack add supravim --force --yes
		printf '\033[92;1mSupravim installed successfully!\033[0m\n'
	fi
}

# check if git, make, zstd is installed
missing_libs=""
missing_commands=""

for cmd in git make zstd pkg-config; do
	if ! command -v "$cmd" >/dev/null 2>&1; then
		missing_commands="$missing_commands $cmd"
	fi
done

if command -v pkg-config >/dev/null 2>&1; then
	for lib in glib-2.0 gio-2.0 gobject-2.0; do
		if ! pkg-config --exists "$lib"; then
			missing_libs="$missing_libs $lib"
		fi
	done
fi

if [ -n "$missing_commands" ] || [ -n "$missing_libs" ]; then
	printf '\033[31;1m[Error]:\033[0m Some dependencies are missing for the build.\n'

	if [ -n "$missing_commands" ]; then
		printf 'Missing commands:%s\n' "$missing_commands"
	fi

	if [ -n "$missing_libs" ]; then
		printf 'Missing libraries:%s\n' "$missing_libs"
	fi

	printf '\n'
	printf '\033[93;1mUbuntu/Debian: \033[0m\033[93mapt install git make zstd libglib2.0-dev valac pkg-config\033[0m\n'
	printf '\033[96;1mArchLinux: \033[0m\033[96mpacman -S git make zstd glib2 vala pkgconf\033[0m\n'
	printf '\033[95;1mmacOS: \033[0m\033[95mbrew install git make zstd glib vala pkg-config\033[0m\n'
	exit 1
fi

# check if IS42 is equal to true

if [ "$IS42" != "true" ]; then
	# check SESSION_MANAGER if the variable contains "42"
	if [ -n "$FT_HOOK_NAME" ]; then
		export IS42="true"
	fi
fi

if [ "$IS42" = "true" ]; then
	printf '\033[93;1mDetected 42 School environment.\033[0m\n'
else
	printf '\033[93;1mNot detected 42 School environment.\033[0m\n'
fi

if command -v suprapack >/dev/null 2>&1; then
	printf '\033[31;1m[Error]:\033[0m suprapack is already installed in the root directory.\n'

	# read from the terminal, not stdin: the script itself is stdin when piped from curl.
	# /dev/tty can exist yet be unopenable (CI, containers), so test opening it, not just its presence.
	choice="n"
	# the probe runs in a subshell: a failed redirection on a special builtin is fatal in POSIX sh
	if (: < /dev/tty) 2>/dev/null; then
		printf 'Do you want to reinstall suprapack? (y/n): '
		read -r choice < /dev/tty || choice="n"
	fi

	if [ "$choice" != "y" ] && [ "$choice" != "Y" ]; then
		install_supravim
		exit 0
	fi

	printf '\033[93;1mReinstalling suprapack...\033[0m\n'
fi

TMPDIR=$(mktemp -d)
PREVDIR=$PWD
cd "$TMPDIR" || exit 1
git clone https://gitlab.com/nda-cunh/suprapack --depth=1
cd suprapack || exit 1
make install
install_supravim
cd "$PREVDIR" || exit 1
