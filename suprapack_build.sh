#!/bin/bash

export PATCH_DIR=$MESON_SOURCE_ROOT/patch
mkdir -p $MESON_INSTALL_DESTDIR_PREFIX/share/supravim/vim/bundle
pushd $MESON_INSTALL_DESTDIR_PREFIX/share/supravim/vim/bundle/


git clone https://github.com/noscript/elevator.vim --depth 1
git clone https://github.com/Donaldttt/fuzzyy --depth 1
git clone https://github.com/jiangmiao/auto-pairs --depth 1
git clone https://github.com/vim-airline/vim-airline --depth 1
git clone https://github.com/nda-cunh/SupraSnake --depth 1
git clone https://github.com/nda-cunh/SupraTree --depth 1
git clone https://github.com/nda-cunh/SupraIcons --depth 1
git clone https://github.com/nda-cunh/SupraPopup --depth 1

rm -rf */.git
rm -rf */.github
rm -rf */README.md
popd

pushd ..
suprapack build $MESON_INSTALL_DESTDIR_PREFIX --install
popd
