#!/bin/sh

SHELL_ACTIVE="${HOME}/.$(basename $SHELL)rc"
BACKUP_FILE="old_conf_vim_$(date +'%Y-%m-%d-%H%M%S').tar"
SUPRA_LINK="https://gitlab.com/Pixailz/SupraVim"
INSTALL_DIRECTORY="${HOME}/.local/bin/SupraVim"

############################################################
# Bash Color
warning='\033[1;5;31m'
blue='\e[34m'
red='\e[31m'
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

############################################################
# main

add_config_rc(){
	if ! grep -qe "^stty stop undef" ${SHELL_ACTIVE}; then
		echo "stty stop undef" >> ${SHELL_ACTIVE}
	fi
	if ! grep -qe "^stty start undef" ${SHELL_ACTIVE}; then
		echo "stty start undef" >> ${SHELL_ACTIVE}
	fi
}

install_SupraVim(){
	download "Cloning repo to ${INSTALL_DIRECTORY}"
	git clone ${SUPRA_LINK} ${INSTALL_DIRECTORY} --progress
	status "Installing SupraVim"
	[ -f ~/.vimrc ] && rm -f ~/.vimrc
	ln -s ${INSTALL_DIRECTORY}/vimrc ~/.vimrc
	[ -f ~/.vimrc ] && rm -f ~/.vim
	ln -s ${INSTALL_DIRECTORY}/vim ~/.vim
	add_config_rc
}
############################################################

############################################################
# main

main() {
	#	clean previous run, update SupraVim in the same way
	[ -d ${INSTALL_DIRECTORY} ] && rm -rf ${INSTALL_DIRECTORY}

	# backup if needed
	[ -d ~/.vim ] && backup_vim_folder
	[ -f ~/.vimrc ] && backup_vimrc

	install_SupraVim
}

main
############################################################
