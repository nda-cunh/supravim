#!/bin/sh

main() {
	init_meson_path

	cd "$(mktemp -d)" || exit 1
	path_build=$PWD
	echo "####################################################################"
	echo "Created temporary directory: $path_build"
	echo "####################################################################"

	create_suprapack

	git clone https://gitlab.com/supraproject/supramake supramake --depth 1
	git clone https://gitlab.com/supraproject/suprabear suprabear --depth 1
	git clone https://gitlab.com/nda-cunh/makeheader.git makeheader --depth 1
	git clone https://gitlab.com/nda-cunh/supravim supravim --depth 1
	# git clone https://gitlab.com/nda-cunh/supravim-gui supravim-gui --depth 1

	create_package supramake
	create_package suprabear
	create_package makeheader
	create_package supravim
	# TODO suprapack-gui need supravim installed
	# create_package supravim-gui

	echo "All build package is build successfully and located in $path_build"
}

create_suprapack() {
	git clone https://gitlab.com/nda-cunh/suprapack --depth 1

	prevdir=$PWD
	cd suprapack || exit 1

	$MESON_CMD
	DESTDIR="$PWD" meson install --skip-subproject -C build
	SUPRAPACK_PATH="$PWD/usr/bin/suprapack"
	echo "Suprapack is build successfully and located in $SUPRAPACK_PATH"
	$SUPRAPACK_PATH build $PWD/usr --build-output "$prevdir"
	cd "$prevdir" || exit 1
}

create_package() {
	echo "Creating package for $1"
	prevdir=$PWD
	cd "$1" || exit 1
	$MESON_CMD
	DESTDIR="$PWD" meson install --skip-subproject -C build
	$SUPRAPACK_PATH build $PWD/usr --build-output "$prevdir"
	cd "$prevdir" || exit 1
}

check_dependencies() {
	missing_commands=""
	for cmd in git make zstd valac meson ninja fakeroot; do
		if ! command -v "$cmd" >/dev/null 2>&1; then
			missing_commands="$missing_commands $cmd"
		fi
	done
	if [ -n "$missing_commands" ]; then
		printf '\033[31;1m[Error]: The following commands are required to run this script:%s\n' "$missing_commands"
		printf '\n'
		if [ $OS = "Linux" ]; then
			printf '\033[93;1m Ubuntu     \033[93m'
			printf 'apt install git make zstd glib-networking valac fakeroot meson ninja-build\n'
			printf '\033[95;1m Fedora     \033[95m'
			printf 'dnf install git make zstd glib-networking vala fakeroot meson ninja-build\n'
			printf '\033[96;1m ArchLinux  \033[96m'
			printf 'pacman -S git make zstd glib-networking vala fakeroot \n'
			printf "\n"
		elif [ $OS = "Darwin" ]; then
			printf '\033[95;1mmacOS: \033[95mbrew install vala pkg-config gcc glib-networking gtk4 curl wget git ccls openssh openssl meson ninja fakeroot\n'
		fi
		printf '\033[0m'
		exit 1
	fi
}

init_meson_path() {
	OS=$(uname -s)
	MESON_CMD='meson build --prefix=/usr --libdir=lib --buildtype=release -Dsuprapack=true --strip'
	if [ $OS = "Darwin" ]; then
		MESON_CMD="$MESON_CMD -Dc_link_args='-Wl,-rpath,"@loader_path/../lib"'"
		# On MacOs check if Homebrew is installed and install required packages
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
		check_dependencies
	elif [ $OS = "Linux" ]; then
		MESON_CMD="$MESON_CMD -Dc_link_args='-Wl,-rpath,\$ORIGIN/../lib'"
		check_dependencies
	else
		echo "Unknown operating system: $OS"
		exit 1
	fi
}

main
