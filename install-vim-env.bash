#!/bin/bash
set -x
# This script installs my vim environment from scratch.
# Works on Arch/Debian/Ubuntu.
do_install(){

    cd ~

    mv .vimrc .vimrc.old || :
    if [ -e '.vim.old' ]; then
        rm -rf .vim.old
    fi
    mv .vim .vim.old || :
    install -d .vim

    git clone https://github.com/robertmeta/nofrils.git ~/git/nofrils

    ln -s git/vim-config/vimrc .vimrc
    ln -s ~/git/nofrils/colors ~/.vim/
}

do_install
