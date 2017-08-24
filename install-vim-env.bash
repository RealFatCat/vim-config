#!/bin/bash
set -x
# This script installs my vim environment from scratch.
# Works on Arch/Debian/Ubuntu.
do_install(){

    OS_NAME="$(cat /etc/*-release | awk -F'=' '/^(OS_)?NAME=/ {print $2}')"
    case $OS_NAME in
        \"Arch\ Linux\")
            sudo pacman -S fzf
            ;;
        \"Debian\"|\"Ubuntu\"|\"Raspbian\ GNU/Linux\")
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/git/fzf
            cd ~/git/fzf/ && ./install --bin --64
            ;;
        *)
            echo WUT?
            exit 1
            ;;
    esac

    cd ~

    mv .vimrc .vimrc.old || :
    if [ -e '.vim.old' ]; then
        rm -rf .vim.old
    fi
    mv .vim .vim.old || :

    install -d ~/.vim/bundle/ ~/git/

    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    git clone https://github.com/robertmeta/nofrils.git ~/git/nofrils

    ln -s git/vim-config/vimrc .vimrc
    ln -s ~/git/nofrils/colors ~/.vim/
    vim +PluginInstall +qall &>/dev/null
}

do_install
