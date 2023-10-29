print_ascii_line() {
	printf "$2$1 \e[0m\n" 
}

print_ascii() {
	print_ascii_line " ____                      __     ___" '\e[31m'
	print_ascii_line "/ ___| _   _ _ __  _ __ __ \ \   / (_)_ __ ___" '\e[38;5;166m'
	print_ascii_line "\\___ \\| | | | '_ \\| '__/ _\` \\ \\ / /| | '_ \` _ \\" '\e[33m'
	print_ascii_line " ___) | |_| | |_) | | | (_| |\\ V / | | | | | | |" '\e[32m'
	print_ascii_line "|____/ \\__,_| .__/|_|  \\__,_| \\_/  |_|_| |_| |_|" '\e[34m'
	print_ascii_line "            |_|" '\e[35m'
}
	
main() {
	rm -rf $HOME/.vimrc $HOME/.vim
	ln -sf $PKGDIR/share/supravim/vim $HOME/.vim
	ln -sf $PKGDIR/share/supravim/vimrc $HOME/.vimrc
	$PKGDIR/share/supravim/apply_cfg "$PKGDIR/share/supravim/supravim.cfg"
	print_ascii
}

main
