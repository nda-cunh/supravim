#!/bin/bash

#create a finction to install supravim

install_supravim() {
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
	echo -e "\033[93;1mUbuntu: \033[0m\033[93mapt install git make zstd glib-networking valac\033[0m"
	echo -e "\033[96;1mArchLinux: \033[0m\033[96mpacman -S git make zstd glib-networking vala\033[0m"
	echo -e "\033[95;1mmacOS: \033[0m\033[95mbrew install git make zstd glib-networking vala\033[0m"
	exit 1
fi

# check if IS42 is equal to true

if [[ "$IS42" != "true" ]]; then
	# check if FT_HOOK_NAME is set
	if [[ -n ${FT_HOOK_NAME} ]]; then
		IS42="true"
		echo -e "\033[93;1m42 school environment detected. Setting IS42 to true.\033[0m"
	fi
fi

# check if suprapack is installed in root directory
if command -v suprapack &> /dev/null; then
	echo -e "\033[31;1m[Error]:\033[0m suprapack is already installed in the root directory."

	# tell if the user wants to reinstall suprapack
	read -p "Do you want to reinstall suprapack? (y/N): " choice
	if [[ "$choice" != "y" && "$choice" != "Y" ]]; then
		install_supravim
		exit 0
	fi

	echo -e "\033[93;1mReinstalling suprapack...\033[0m"
fi

TMPDIRSUPRA=$(mktemp -d)
pushd "$TMPDIRSUPRA"
git clone https://gitlab.com/nda-cunh/suprapack --depth=1
cd suprapack
make install
install_supravim
popd
