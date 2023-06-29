#!/bin/sh

SHELL_ACTIVE="${HOME}/.$(basename $SHELL)rc"
SUPRA_LINK="https://gitlab.com/Hydrasho/SupraVim -b $1"
INSTALL_DIRECTORY="${HOME}/.local/share/SupraVim"

############################################################
# Bash Color
warning='\033[1;5;31m'
blue='\e[34m'
red='\e[31m'
orange='\e[38;5;166m'
yellow='\e[33m'
green='\e[32m'
purple='\e[35m'
download='\e[1;93m'
restore='\e[0m'
reset='\e[0m'
############################################################

############################################################
# Utils function for printing
status() {
	printf "${blue}[ INFOS ]${reset} $1\n"
}

download() {
	printf "${download}[GETTING]${reset} $1\n"
}

warning() {
	printf "${warning}[WARNING]${reset} $1\n"
}

error() {
	printf "${red}[ ERROR ]${reset} $1\n"
	exit
}
############################################################

############################################################
# backup function

step=1
backup_config() {
	if [ -f ~/.vimrc ] && [ `grep -c "** SUPRAVIM **" ~/.vimrc` -eq 0 ] ; then
		status "Switching your vim configuration, to restore it use \033[1msupravim switch\033[0m"
		supravim switch >/dev/null
	fi
	if [ $step -eq 1 ]; then
		balise="`grep -Ezo "#[=]+.*[=]{42}" ~/.vimrc 2>/dev/null | tr -d '\0'`"
		if [ "$balise" = "" ]; then
			balise="#====================== YOUR CONFIG =======================\n\
#=========================================================="
		fi
		mouse=$(grep -c "#\*mouse\*" ~/.vimrc 2>/dev/null)
		swap=$(grep -c "#.*noswapfile" ~/.vimrc 2>/dev/null)
		nerdtree=$(grep -c "#\*nerdtree\*" ~/.vimrc 2>/dev/null)
		theme=$(cat ~/.vimrc 2>/dev/null | grep colorscheme | grep -Eo "[a-z]+$")
		icons=$(grep -c "icons_enabled" ~/.vimrc 2>/dev/null)
		norme=$(grep -c "norm_activate = false" ~/.vimrc 2>/dev/null)
		step=2
	elif [ $step -eq 2 ]; then
		if [ "$icons" = "0" ]; then
			# download "devicons for icons"
			supravim disable icons >/dev/null
		fi
		! [ "$mouse" = "0" ] && supravim disable mouse >/dev/null
		  [ "$swap" = "0" ] && supravim disable swap >/dev/null
		! [ "$nerdtree" = "0" ] && supravim disable tree >/dev/null
		  [ "$norme" = "0" ] && supravim enable norme >/dev/null
		
		supravim -t "$theme" >/dev/null
		printf "$balise" >> ~/.vimrc
		status "Have reloaded your old vim configuration"
	fi
}

############################################################
# Installation

add_config_rc(){
	if ! grep -qe "^stty stop undef" ${SHELL_ACTIVE} >/dev/null; then
		echo "stty stop undef" >> ${SHELL_ACTIVE}
	fi
	if ! grep -qe "^stty start undef" ${SHELL_ACTIVE} >/dev/null; then
		echo "stty start undef" >> ${SHELL_ACTIVE}
	fi
	if ! grep -qe "^alias smake=supramake" ${SHELL_ACTIVE} >/dev/null; then
		echo "alias smake=supramake" >> ${SHELL_ACTIVE}
	fi
	if ! grep -qE "^export PATH=.*[\$]HOME/\.local/bin.*$" ${SHELL_ACTIVE} >/dev/null; then
		status "Adding path ($HOME/.local/bin)"
		echo "export PATH=\$HOME/.local/bin:\$PATH" >> ${SHELL_ACTIVE}
	fi
	if ! grep -qe "^alias q=exit" ${SHELL_ACTIVE} >/dev/null; then
		echo "alias q=exit" >> ${SHELL_ACTIVE}
	fi
	if ! grep -qe "^export fpath=(${INSTALL_DIRECTORY}/bin \$fpath)" ${SHELL_ACTIVE} >/dev/null; then
		echo "export fpath=(${INSTALL_DIRECTORY}/bin \$fpath)" >> ${SHELL_ACTIVE}
		echo "autoload compinit; compinit" >> ${SHELL_ACTIVE}
	fi
}

config_supravim_editor() {
	cp -rf "${INSTALL_DIRECTORY}/bin/supravim" $HOME/.local/bin/
    ln -sf "${INSTALL_DIRECTORY}/bin/clangd" $HOME/.local/bin/
	ln -sf "${INSTALL_DIRECTORY}/bin/suprabrain" $HOME/.local/bin/
    ln -sf "${INSTALL_DIRECTORY}/bin/supramake" $HOME/.local/bin/
	chmod +x $HOME/.local/bin/suprabrain
	chmod +x $HOME/.local/share/SupraVim/bin/suprago
	mkdir -p $HOME/.local/share/fonts
    mv "${INSTALL_DIRECTORY}/data/ubuntuNerdFont.ttf" $HOME/.local/share/fonts/ubuntuNerdFont.ttf
}


install_SupraVim(){
	mkdir -p $INSTALL_DIRECTORY
	download "Cloning repo to ${INSTALL_DIRECTORY}"
	git clone ${SUPRA_LINK} ${INSTALL_DIRECTORY} --progress
	status "Installing SupraVim"
	rm -rf ~/.vimrc
	rm -rf ~/.vim
	ln -s ${INSTALL_DIRECTORY}/data/vimrc ~/.vimrc
	ln -s ${INSTALL_DIRECTORY}/data/vim ~/.vim
	config_supravim_editor
	add_config_rc
}
############################################################

############################################################
# print ascii line by line wiht rainbow colors

print_ascii_line() {
	printf "$2$1 ${reset}\n" 
}

print_ascii() {
	print_ascii_line " ____                      __     ___" ${red}
	print_ascii_line "/ ___| _   _ _ __  _ __ __ \ \   / (_)_ __ ___" ${orange}
	print_ascii_line "\\___ \\| | | | '_ \\| '__/ _\` \\ \\ / /| | '_ \` _ \\" ${yellow}
	print_ascii_line " ___) | |_| | |_) | | | (_| |\\ V / | | | | | | |" ${green}
	print_ascii_line "|____/ \\__,_| .__/|_|  \\__,_| \\_/  |_|_| |_| |_|" ${blue}
	print_ascii_line "            |_|" ${purple}
}
############################################################
# main

main() {
	#	Prepare config for new upload
	echo "Kill all vim before update"
	killall vim
	killall suprabrain
	echo "You are on the $1 branch"
	backup_config

	#	clean previous run, update SupraVim in the same way
	[ -d ${INSTALL_DIRECTORY} ] && rm -rf ${INSTALL_DIRECTORY}

	install_SupraVim
	backup_config
	print_ascii
}

main $1
############################################################
