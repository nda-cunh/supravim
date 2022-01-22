#!/bin/sh
SV_VERSION="0"
SHELL_ACTIVE="${HOME}/.$(basename $SHELL)rc"

null() {
	"$@" >/dev/null 2>&1
}

cd ~
if [ -d $HOME/.SupraVim ]; then
	#	echo "Update Supravim"
	(cd .SupraVim && null git stash && null git pull &)
else
	echo "Clone du depot"
	git clone https://gitlab.com/hydrasho/SupraVim .SupraVim --progress

	if [ -d $HOME/.vim ] && [ -f $HOME/.vimrc ]; then
		echo "Sauvegarde de vos anciennes configurations Vim : ~/old-conf-vim.tar"
		tar -cf old-conf-vim.tar .vim .vimrc .vim*
		rm -rf .vim .vimrc .vim*
	fi

	echo "Suppresion de l'ancien vim"
	mv ~/.vim ~/.vimold
	mv ~/.vimrc ~/.vimrcold
	rm -rf ~/.vim
	rm -rf ~/.vimrc
	echo "Installation du SupraVim"
	ln -s .SupraVim/vimrc $HOME/.vimrc
	ln -s .SupraVim/vim $HOME/.vim
	echo "stty stop undef" >> ~/.zshrc
	echo "stty start undef" >> ~/.zshrc
	echo "Redemarrez votre terminal ;)"
fi
