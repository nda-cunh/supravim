#!/bin/bash

export PATCH_DIR=$MESON_SOURCE_ROOT/patch
mkdir -p $MESON_INSTALL_DESTDIR_PREFIX/share/supravim/vim/bundle
pushd $MESON_INSTALL_DESTDIR_PREFIX/share/supravim/vim/bundle/
git clone https://github.com/noscript/elevator.vim
# git clone https://github.com/ryanoasis/vim-devicons
# pushd vim-devicons
# git apply $PATCH_DIR/more-icons.patch
# popd
# git clone https://github.com/preservim/nerdtree
git clone https://github.com/Donaldttt/fuzzyy
git clone https://github.com/jiangmiao/auto-pairs
git clone https://github.com/vim-airline/vim-airline.git
rm -rf */.git
rm -rf */.github
rm -rf */README.md
popd

pushd ..
suprapack build $MESON_INSTALL_DESTDIR_PREFIX --install
popd
