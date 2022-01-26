#!/bin/bash
set -ex

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
COLORS_URL="https://github.com/robertmeta/nofrils.git"
COLORS_DST="${HOME}/git/robertmeta/nofrils"
HOME_VIM_DIR="${HOME}/.vim"
HOME_VIMRC="${HOME}/.vimrc"

if [ -d "${HOME_VIM_DIR}" ]; then
    mv -f ${HOME_VIM_DIR} ${HOME_VIM_DIR}.old
fi
install -d ${HOME_VIM_DIR}

if [ -e "${HOME_VIMRC}" ]; then
    mv -f ${HOME_VIMRC} ${HOME_VIMRC}.old
fi

git clone ${COLORS_URL} ${COLORS_DST}

ln -s ${SCRIPTPATH}/vimrc ${HOME_VIMRC}
ln -s ${COLORS_DST}/colors ${HOME_VIM_DIR}
