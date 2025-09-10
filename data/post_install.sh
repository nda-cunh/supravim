print_ascii_line() {
	printf "$2$1 \e[0m\n" 
}

print_ascii() {
	cat $PKGDIR/share/supravim/supravim_ascii
	# print_ascii_line " ____                      __     ___" '\e[31m'
	# print_ascii_line "/ ___| _   _ _ __  _ __ __ \ \   / (_)_ __ ___" '\e[38;5;166m'
	# print_ascii_line "\\___ \\| | | | '_ \\| '__/ _\` \\ \\ / /| | '_ \` _ \\" '\e[33m'
	# print_ascii_line " ___) | |_| | |_) | | | (_| |\\ V / | | | | | | |" '\e[32m'
	# print_ascii_line "|____/ \\__,_| .__/|_|  \\__,_| \\_/  |_|_| |_| |_|" '\e[34m'
	# print_ascii_line "            |_|" '\e[35m'

	printf '╭─────────────────────────────────────────────────────────╮\n'
	printf '│ If you like my work, please star the project on GitHub: │\n'
	printf '│ Link: \e[1;94mhttps://github.com/nda-cunh/supravim\e[;0m              │\n'
	printf '│ Thank you !!!                                           │\n'
	printf '╰─────────────────────────────────────────────────────────╯\n'

}

create_folder_undo () {
	DIR="$HOME/.cache/vim/"

	mkdir -p "$DIR/undo" 2>/dev/null | true
	chmod 755 -R "$DIR" 2>/dev/null | true
	# bug for 42 school (nfs)
	mkdir -p "$DIR/undo" 2>/dev/null | true
	chmod 755 -R "$DIR" 2>/dev/null | true
}

main() {
	# Remove View (mkview)
	rm -rf $HOME/.vim/view/
	# Remove old vimrc and vim folder
	rm -rf $HOME/.vimrc $HOME/.vim
	ln -sf $PKGDIR/share/supravim/vim $HOME/.vim
	ln -sf $PKGDIR/share/supravim/vimrc $HOME/.vimrc
	$PKGDIR/bin/supravim --apply-config 2>/dev/null | true
	print_ascii
	create_folder_undo
	git config --global core.editor "vim" | true
}

main
