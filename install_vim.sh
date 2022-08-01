#!/bin/sh

SHELL_ACTIVE="${HOME}/.$(basename $SHELL)rc"
BACKUP_FILE="old_conf_vim_$(date +'%Y-%m-%d-%H%M%S').tar"
SUPRA_LINK="https://gitlab.com/Hydrasho/SupraVim -b $1"
INSTALL_DIRECTORY="${HOME}/.local/bin/SupraVim"

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
backup_vim_folder() {
	status "Adding old vim folder to ${BACKUP_FILE}"
	tar -cvf ${BACKUP_FILE} --absolute-names ~/.vim
	rm -rf ~/.vim
}

backup_vimrc() {
	status "Adding old vimrc to ${BACKUP_FILE}"
	if [ -f ~/${BACKUP_FILE} ]; then
		tar -cvf ${BACKUP_FILE} ~/.vim 2>/dev/null
	else
		tar -rvf ${BACKUP_FILE} ~/.vim 2>/dev/null
	fi
	rm -f ~/.vimrc
}

step=1
backup_config() {
	if [ -f ~/.vimrc_supravim_off ]
	then
		supravim switch >/dev/null
	fi
	if [ $step -eq 1 ]; then
		autopairs=$(grep -c "\"\*autopairs\* " ~/.vimrc)
		mouse=$(grep -c "\"\*mouse\*" ~/.vimrc)
		nerdtree=$(grep -c "\"\*nerdtree\*" ~/.vimrc)
		theme=$(cat ~/.vimrc | grep colorscheme | grep -Eo "[a-z]+$")
		devicons=$(if [ -d ~/.vim/bundle/devicons ]; then echo 1; else echo 0; fi)
		step=2
	else
		if [ $autopairs -gt 0 ]; then
			supravim enable autopairs >/dev/null
		fi
		if [ $mouse -gt 0 ]; then
			supravim disable mouse >/dev/null
		fi
		if [ $nerdtree -gt 0 ]; then
			supravim disable nerdtree >/dev/null
		fi
		if [ $devicons -gt 0 ]; then
			supravim enable icons >/dev/null
		fi
		supravim -t "$theme" >/dev/null
		status "Have reloaded your old vim configuration"
	fi
}

############################################################
# Installation

add_config_rc(){
	if ! grep -qe "^stty stop undef" ${SHELL_ACTIVE}; then
		echo "stty stop undef" >> ${SHELL_ACTIVE}
	fi
	if ! grep -qe "^stty start undef" ${SHELL_ACTIVE}; then
		echo "stty start undef" >> ${SHELL_ACTIVE}
	fi
	if ! grep -qE "^export PATH=.*[\$]HOME/\.local/bin.*$" ${SHELL_ACTIVE}; then
		status "Adding path ($HOME/.local/bin)"
		echo "export PATH=\$HOME/.local/bin:\$PATH" >> ${SHELL_ACTIVE}
	fi
	if ! grep -qe "^alias q=exit" ${SHELL_ACTIVE}; then
		echo "alias q=exit" >> ${SHELL_ACTIVE}
	fi
	if ! grep -qe "^source ~/.local/bin/supravim" ${SHELL_ACTIVE}; then
		echo "source ~/.local/bin/supravim >/dev/null" >> ${SHELL_ACTIVE}
	fi
}

config_supravim_editor() {
	cp "${INSTALL_DIRECTORY}/supravim" $HOME/.local/bin/
    chmod +x $HOME/.local/bin/supravim
	#ln -s ${INSTALL_DIRECTORY}/supravim $HOME/.local/bin
}


install_SupraVim(){
	download "Cloning repo to ${INSTALL_DIRECTORY}"
	git clone ${SUPRA_LINK} ${INSTALL_DIRECTORY} --progress
	status "Installing SupraVim"
	[ -f ~/.vimrc ] && rm -f ~/.vimrc
	ln -s ${INSTALL_DIRECTORY}/vimrc ~/.vimrc
	[ -f ~/.vimrc ] && rm -f ~/.vim
	ln -s ${INSTALL_DIRECTORY}/vim ~/.vim
	config_supravim_editor
	add_config_rc
}
############################################################

############################################################
# print ascii line by line wiht rainbow colors

print_ascii_line() {
	echo "$2$1 ${reset}" 
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
	echo "vous êtes sur la branche $1"
	backup_config

	balise=`grep -Ezo "\"[=]+.*[=]{52}" ~/.vimrc`
	if [ "$balise" = "" ]; then
		echo "Yes"
		balise="\"====================== YOUR CONFIG =======================\\n
\"=========================================================="
	else
		echo "Last config updated :)"
	fi

	#	clean previous run, update SupraVim in the same way
	[ -d ${INSTALL_DIRECTORY} ] && rm -rf ${INSTALL_DIRECTORY}

	# backup if needed
	[ -d ~/.vim ] && backup_vim_folder
	[ -f ~/.vimrc ] && backup_vimrc

	install_SupraVim
	# config_supravim_editor
	backup_config
	echo "$balise" >> ~/.vimrc
	print_ascii
}

main
############################################################
