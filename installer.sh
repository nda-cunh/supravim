#!/bin/sh
#based on sublivim 
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
	git clone https://github.com/hydrasho/SupraVim .SupraVim --progress

	if [ -d $HOME/.vim ] && [ -f $HOME/.vimrc ]; then
		echo "Sauvegarde de vos anciennes configurations Vim : ~/old-conf-vim.tar"
		tar -cf old-conf-vim.tar .vim .vimrc
		rm -rf .vim .vimrc
	fi

	echo "Installation du SupraVim"
	ln -s .SupraVim/vimrc $HOME/.vimrc
	ln -s .SupraVim/vim $HOME/.vim
	echo "stty stop undef" >> ~/.zshrc
	echo "stty start undef" >> ~/.zshrc
fi
