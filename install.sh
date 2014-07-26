#!/bin/bash

if [ "steup" = "$0" ]; then
echo "Step0: Installing packages"
if which apt-get >/dev/null; then
	sudo apt-get install -y vim vim-gnome ctags xclip astyle python-setuptools python-dev git cscope Cmake global
elif which yum >/dev/null; then
	sudo yum install -y gcc vim git ctags xclip astyle python-setuptools python-devel cscope Cmake global
fi

##Add HomeBrew support on  Mac OS
if which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle cscope global
    ##Fix twisted installation Error in Mac caused by Xcode Version limit
    sudo ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future easy_install twisted
fi
fi

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
        echo "In .vim dir"
else
    mv $HOME/.vim $HOME/.vim_bak
    mv $HOME/.vimrc $HOME/.vimrc_bak
    lnif $CURRENT_DIR/vimrc $HOME/.vimrc
    lnif "$CURRENT_DIR/" "$HOME/.vim"
fi

echo "Step2: install vundle"
if [ ! -e $CURRENT_DIR/bundle/vundle ]; then
    echo "Installing Vundle"
    git clone https://github.com/gmarik/vundle.git $CURRENT_DIR/bundle/vundle
else
    echo "Upgrade Vundle"
    cd "$HOME/.vim/bundle/vundle" && git pull origin master
fi

echo "Step3: update/install plugins using Vundle"
system_shell=$SHELL
export SHELL="/bin/sh"
echo "installing ...." > xianyovim
echo "sucess auto exit" >> xianyovim
echo "please wait" >> xianyovim
vim xianyovim +BundleInstall! +BundleClean +qall
rm xianyovim
export SHELL=$system_shell

if [ "steup" = "$0" ]; then
echo "Step4: compile YouCompleteMe"
echo "It will take a long time, just be patient!"
echo "If error,you need to compile it yourself"
echo "cd $CURRENT_DIR/bundle/YouCompleteMe/ && bash -x install.sh --clang-completer"
cd $CURRENT_DIR/bundle/YouCompleteMe/
bash -x install.sh --clang-completer
fi

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
