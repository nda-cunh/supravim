#!/bin/sh

# On MacOs check if Homebrew is installed and install required packages
if [ "$(uname -s)" = "Darwin" ]; then
	if ! command -v brew >/dev/null 2>&1; then
		printf '\033[95;1m[Error]:\033[0m Homebrew is not installed. Please install it from https://brew.sh/\n'

		# read from the terminal, not stdin: the script itself is stdin when piped from curl.
		# /dev/tty can exist yet be unopenable, so test opening it in a subshell — a failed
		# redirection on a special builtin is fatal in POSIX sh.
		install_brew="n"
		if (: < /dev/tty) 2>/dev/null; then
			printf 'Do you want to install Homebrew? (y/n): '
			read -r install_brew < /dev/tty || install_brew="n"
		fi

		if [ "$install_brew" = "y" ] || [ "$install_brew" = "Y" ]; then
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
			brew install vala pkg-config gcc glib-networking gtk4 curl wget git ccls openssh openssl meson ninja fakeroot
		else
			printf '\033[95;1mPlease install Homebrew to continue.\033[0m\n'
			exit 1
		fi
	fi
fi

missing_commands=""
for cmd in git make zstd valac meson ninja fakeroot; do
	if ! command -v "$cmd" >/dev/null 2>&1; then
		missing_commands="$missing_commands $cmd"
	fi
done

if [ -n "$missing_commands" ]; then
	printf '\033[31;1m[Error]:\033[0m The following commands are required to run this script:%s\n' "$missing_commands"
	printf '\n'
	printf '\033[93;1mUbuntu: \033[0m\033[93mapt install git make zstd glib-networking valac fakeroot meson ninja-build\033[0m\n'
	printf '\033[96;1mArchLinux: \033[0m\033[96mpacman -S git make zstd glib-networking vala fakeroot \033[0m\n'
	printf '\033[95;1mmacOS: \033[0m\033[95mbrew install vala pkg-config gcc glib-networking gtk4 curl wget git ccls openssh openssl meson ninja fakeroot\033[0m\n'
	exit 1
fi

cd "$(mktemp -d)" || exit 1
echo "####################################################################"
echo "Created temporary directory: $PWD"
echo "####################################################################"

create_package() {
	echo "Creating package for $1"
	prevdir=$PWD
	cd "$1" || exit 1
	meson build --prefix="$PWD/usr" --libdir="$PWD/usr/lib" --bindir="$PWD/usr/bin"
	ninja -C build install
	cd "$prevdir" || exit 1
}

git clone https://gitlab.com/supraproject/supramake supramake --depth 1
git clone https://gitlab.com/supraproject/suprabear suprabear --depth 1
git clone https://gitlab.com/nda-cunh/makeheader.git makeheader --depth 1
git clone https://gitlab.com/nda-cunh/supravim supravim --depth 1
git clone https://gitlab.com/nda-cunh/supravim-gui supravim-gui --depth 1

create_package supramake
create_package suprabear
create_package supravim-gui
create_package makeheader
create_package supravim

mv */*.suprapack .

suprapack add *.suprapack
