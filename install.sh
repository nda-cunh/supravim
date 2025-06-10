#!/bin/bash
# check if git, make, zstd is installed
if ! command -v git &> /dev/null || ! command -v make &> /dev/null || ! command -v zstd &> /dev/null; then
	echo -e "\033[31;1m[Error]:\033[0m git, make, and zstd are required to run this script."
	echo -e ""
	echo -e "\033[93;1mUbuntu: \033[0m\033[93mapt install git make zstd glib-networking valac"
	echo -e "\033[96;1mArchLinux: \033[0m\033[96mpacman -S git make zstd glib-networking vala"
	exit 1
fi

# check if suprapack is installed in root directory
if command -v suprapack &> /dev/null; then
	echo -e "\033[31;1m[Error]:\033[0m suprapack is already installed in the root directory."

	# tell if the user wants to reinstall suprapack
	read -p "Do you want to reinstall suprapack? (y/n): " choice
	if [[ "$choice" != "y" && "$choice" != "Y" ]]; then
		suprapack add supravim --force --yes
		exit 0
	fi

	echo -e "\033[93;1mReinstalling suprapack...\033[0m"
fi

git clone https://gitlab.com/nda-cunh/suprapack --depth=1
cd suprapack
make install
./suprapack add supravim --force --yes