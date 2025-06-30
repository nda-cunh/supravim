#!/bin/bash

#create a finction to install supravim

install_supravim() {
	export PATH=$TMPDIR/suprapack:$PWD:$PATH
	echo -e "\033[93;1mInstalling supravim...\033[0m"
	# if IS42 is true, install plugin-norminette plugin-42formatter
	if [[ "$IS42" == "true" ]]; then
		suprapack add supravim plugin-norminette plugin-42formatter --force --yes
		echo -e "\033[92;1mSupravim and 42 plugins installed successfully!\033[0m"
	else
		suprapack add supravim --force --yes
		echo -e "\033[92;1mSupravim installed successfully!\033[0m"
	fi
}

# check if git, make, zstd is installed
required_commands=("git" "make" "zstd")
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
	echo -e '\033[93;1mUbuntu: \033[0m\033[93mapt install git make zstd glib-networking valac\033[0m'
	echo -e '\033[96;1mArchLinux: \033[0m\033[96mpacman -S git make zstd glib-networking vala\033[0m'
	echo -e "\033[95;1mmacOS: \033[0m\033[95mbrew install git make zstd glib-networking vala\033[0m"
	exit 1
fi

# check if IS42 is equal to true

if [[ "$IS42" != "true" ]]; then
	# check SESSION_MANAGER if the variable contains "42"
	if [[ -n "$FT_HOOK_NAME" ]]; then
		export IS42="true"
	fi
fi

if [[ "$IS42" == "true" ]]; then
	echo -e "\033[93;1mDetected 42 School environment.\033[0m"
else
	echo -e "\033[93;1mNot detected 42 School environment.\033[0m"
fi

# check if suprapack is installed in root directory
if command -v suprapack &> /dev/null; then
	echo -e "\033[31;1m[Error]:\033[0m suprapack is already installed in the root directory."

	# tell if the user wants to reinstall suprapack
	read -p "Do you want to reinstall suprapack? (y/n): " choice
	if [[ "$choice" != "y" && "$choice" != "Y" ]]; then
		install_supravim
		exit 0
	fi

	echo -e "\033[93;1mReinstalling suprapack...\033[0m"
fi

TMPDIR=$(mktemp -d)
pushd "$TMPDIR"
git clone https://gitlab.com/nda-cunh/suprapack --depth=1
cd suprapack
make install
install_supravim
popd

