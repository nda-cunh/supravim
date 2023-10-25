############################################################
# Bash Color
blue='\e[34m'
red='\e[31m'
orange='\e[38;5;166m'
yellow='\e[33m'
green='\e[32m'
purple='\e[35m'
reset='\e[0m'
############################################################

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
	
main() {
	#rm -rf $HOME/.vimrc
	#rm -rf $HOME/.vim
	echo "SRCDIR = $SRCDIR"
	echo "PKGDIR = $PKGDIR"
	echo "-sf $PKGDIR/share/supravim/vim $HOME/.vim"
	echo "-sf $PKGDIR/share/supravim/vimrc $HOME/.vimrc"
	#ln -sf $PKGDIR/share/supravim/vim $HOME/.vim
	#ln -sf $PKGDIR/share/supravim/vimrc $HOME/.vimrc
	print_ascii
}

main
