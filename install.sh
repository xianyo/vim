#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}

echo "Step1: setting up files"
if [ "$HOME/.vim" = $CURRENT_DIR ]; then
        mv $HOME/.vimrc $HOME/.vimrc_bak
        lnif $CURRENT_DIR/vimrc $HOME/.vimrc
        echo "    In .vim dir"
else
    mv $HOME/.vim $HOME/.vim_bak
    mv $HOME/.vimrc $HOME/.vimrc_bak
    lnif $CURRENT_DIR/vimrc $HOME/.vimrc
    lnif "$CURRENT_DIR/" "$HOME/.vim"
fi

echo "Step2: install vundle"
if [ ! -e $CURRENT_DIR/bundle/vundle ]; then
    echo "    Installing Vundle"
    git clone https://github.com/gmarik/vundle.git $CURRENT_DIR/bundle/vundle
else
    echo "    Upgrade Vundle"
    cd "$HOME/.vim/bundle/vundle" && git pull origin master
fi

echo "Step3: update/install plugins using Vundle"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u $HOME/.vimrc.bundles +BundleInstall! +BundleClean +qall
export SHELL=$system_shell


echo "Step4: compile YouCompleteMe"
echo "    It will take a long time, just be patient!"
echo "    If error,you need to compile it yourself"
echo "    cd $CURRENT_DIR/bundle/YouCompleteMe/ && bash -x install.sh --clang-completer"
cd $CURRENT_DIR/bundle/YouCompleteMe/
bash -x install.sh --clang-completer

#vim bk and undo dir
if [ ! -d /tmp/vimbk ]
then
    mkdir -p /tmp/vimbk
fi

if [ ! -d /tmp/vimundo ]
then
    mkdir -p /tmp/vimundo
fi

echo "Install Done!"
