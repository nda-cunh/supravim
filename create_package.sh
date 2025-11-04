#!/bin/bash





# On MacOs check if Homebrew is installed and install required packages
if [[ "$OSTYPE" == "darwin"* ]]; then
	if ! command -v brew &> /dev/null; then
		echo -e '\033[95;1m[Error]:\033[0m Homebrew is not installed. Please install it from https://brew.sh/'
		read -p "Do you want to install Homebrew? (y/n): " install_brew
		if [[ "$install_brew" == "y" ]]; then
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
			brew install vala pkg-config gcc glib-networking gtk4 curl wget git ccls openssh openssl meson ninja fakeroot
		else
			echo -e "\033[95;1mPlease install Homebrew to continue.\033[0m"
			exit 1
		fi
	fi
fi

required_commands=("git" "make" "zstd" "valac" "meson" "ninja" "fakeroot")
# Vérification de chaque commande
missing_commands=()
for cmd in "${required_commands[@]}"; do
	if ! command -v "$cmd" &> /dev/null; then
		missing_commands+=("$cmd")
	fi
done

if [ ${#missing_commands[@]} -ne 0 ]; then
	echo -e "\033[31;1m[Error]:\033[0m The following commands are required to run this script: ${missing_commands[*]}"
	echo -e ""
	echo -e '\033[93;1mUbuntu: \033[0m\033[93mapt install git make zstd glib-networking valac fakeroot meson ninja-build\033[0m'
	echo -e '\033[96;1mArchLinux: \033[0m\033[96mpacman -S git make zstd glib-networking vala fakeroot \033[0m'
	echo -e "\033[95;1mmacOS: \033[0m\033[95mbrew install vala pkg-config gcc glib-networking gtk4 curl wget git ccls openssh openssl meson ninja fakeroot\033[0m"
	exit 1
fi


cd $(mktemp -d)

create_package() {
	echo "Creating package for $1"
	pushd $1
	meson build --prefix=$PWD/usr --libdir=$PWD/usr/lib --bindir=$PWD/usr/bin
	ninja -C build install
	popd
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
