#!/bin/bash

create_package() {
	echo "Creating package for $1"
	pushd $1
	meson build --prefix=$PWD/usr --libdir=$PWD/usr/lib --bindir=$PWD/usr/bin
	ninja -C build install
	popd
}

git clone https://gitlab.com/supraproject/supramake supramake
git clone https://gitlab.com/supraproject/suprabear suprabear
git clone https://gitlab.com/nda-cunh/supravim-gui supravim-gui
git clone https://gitlab.com/nda-cunh/makeheader.git makeheader
git clone https://gitlab.com/supraproject/supravim-server.git

create_package supramake
create_package suprabear
create_package supravim-gui
create_package makeheader
create_package supravim-server

mv */*.suprapack .
