#!/bin/sh
SV_VERSION="0"
SHELL_ACTIVE="${HOME}/.$(basename $SHELL)rc"

null() {
	"$@" >/dev/null 2>&1
}

cd $HOME
if [ -d $HOME/.SupraVim ]; then
	rm -rf $HOME/.SupraVim
fi

if [ -d $HOME/.vim ] && [ -f $HOME/.vimrc ]; then
		echo "Sauvegarde de vos anciennes configurations Vim : ~/old-conf-vim.tar"
		tar -cf old-conf-vim.tar .vim .vimrc .vim*
		rm -rf .vim .vimrc .vim*
		echo "Suppresion de l'ancien vim"
		mv ~/.vim ~/.vimold
		mv ~/.vimrc ~/.vimrcold
		rm -rf ~/.vim
		rm -rf ~/.vimrc
fi

echo "Clone du depot"
git clone https://gitlab.com/hydrasho/SupraVim .SupraVim --progress

echo "Installation du SupraVim"
if [ -f $HOME/.vimrc]; then
	rm -f $HOME/.vimrc
fi
if [ -f $HOME/.vim]; then
	rm -rf $HOME/.vim
fi
ln -s .SupraVim/vimrc $HOME/.vimrc
ln -s .SupraVim/vim $HOME/.vim
if [ -z $(cat ${SHELL_ACTIVE} | grep "stty stop undef") ]; then
	echo "stty stop undef" >> ~/.zshrc
fi
if [ -z $(cat ${SHELL_ACTIVE} | grep "stty start undef") ]; then
	echo "stty start undef" >> ~/.zshrc
fi
echo "Redemarrez votre terminal ;)"

