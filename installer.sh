#!/bin/sh

curl https://gitlab.com/hydrasho/SupraVim/-/raw/master/install_vim.sh > install_vim.sh
chmod +x ./install_vim.sh
./install_vim.sh master
rm -rf ./install_vim.sh
