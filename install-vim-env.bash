#!/bin/bash
# This script installs my vim environment from scratch.
# Works on Arch/Debian/Ubuntu.

try_get_git(){
# Here we trying to install git

    local OS_NAME="$(egrep '^NAME=' /etc/issue | awk -F'=' '{print $2}')"
    case ${OS_NAME} in
        \"Arch\ Linux\")
        pacman -S git
        ;;
        \"Debian\"|\"Ubuntu\"|\"Raspbian\ GNU/Linux\")
        apt-get update -qq
        apt-get install git
        ;;
    esac

}

check_git(){
    if [ -z "$(which git)" ]; then
        printf "git is not found, trying to get it...\n"
        try_get_git
        if [ $? -ne 0 ]; then
            printf "Could not get git :(\nTry to install it manually.\nExit.\n"
            exit 1
        fi
    fi
}

do_install(){
    check_git
    cd ~
    install -d ~/.vim/bundle/ ~/git/vim-config
    git clone https://github.com/RealFatCat/vim-config.git ~/git/vim-config
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    if [ -e ~/.vimrc ]; then
        mv ~/.vimrc{,.old}
    fi
    ln -s git/vim-config/.vimrc
    vim +PluginInstall +qall
    ln -s ~/git/vim-config/.vim/colors ~/.vim/
}

if [ "$(basename $0)" == "install-vim-env.bash" ]; then
    do_install
fi

