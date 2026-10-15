#!/bin/bash

export PATCH_DIR=$MESON_SOURCE_ROOT/patch
mkdir -p "$MESON_INSTALL_DESTDIR_PREFIX/share/supravim/vim/bundle"
pushd "$MESON_INSTALL_DESTDIR_PREFIX/share/supravim/vim/bundle/" || exit 1

clone() {
	BASE_NAME=$(basename "$1" .git)
	git clone "$1" --depth 1
	rm -rf "$BASE_NAME/.git"
	rm -rf "$BASE_NAME/test"
	rm -rf "$BASE_NAME/.github"
	rm -rf "$BASE_NAME"/*.md
	rm -rf "$BASE_NAME/LICENSE"
	rm -rf "$BASE_NAME/CONTRIBUTING.md"
}

# External SupraVim plugins
clone "https://github.com/nda-cunh/ScrollBar.git"
clone "https://github.com/nda-cunh/vim9-autopairs.git"
clone "https://github.com/nda-cunh/SupraSnake"
clone "https://github.com/nda-cunh/SupraTree"
clone "https://github.com/nda-cunh/SupraWater"
clone "https://github.com/nda-cunh/SupraComment"
clone "https://github.com/nda-cunh/SupraIcons"
clone "https://github.com/nda-cunh/SupraPopup"
clone "https://github.com/nda-cunh/SupraPacman"
clone "https://github.com/nda-cunh/PropColor"
clone "https://github.com/nda-cunh/Crumble.vim"
clone "https://github.com/nda-cunh/dvd.vim"
clone "https://github.com/nda-cunh/SupraIndent"
# External plugins
clone "https://github.com/Donaldttt/fuzzyy"
clone "https://github.com/vim-airline/vim-airline"
clone "https://github.com/hrsh7th/vim-vsnip"
clone "https://github.com/hrsh7th/vim-vsnip-integ"

popd || exit 1
