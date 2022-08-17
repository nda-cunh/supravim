#!/bin/sh

curl https://gitlab.com/hydrasho/SupraVim/-/raw/dev/install_vim.sh > install_vim.sh
chmod +x ./install_vim.sh
./install_vim.sh dev
rm -rf ./install_vim.sh