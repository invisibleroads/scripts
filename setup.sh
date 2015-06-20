#!/bin/bash

SCRIPTS=~/.scripts
if [ ! -e $SCRIPTS ]; then
    mkdir $SCRIPTS
fi

for filename in .bash_profile .bashrc .gvimrc .tmux.conf .vimrc
do
    cp $filename ~
    echo 'cp '$filename ~
done

for filename in clean disable-backlight git-status grep- pause-lock put-key venv *.py
do
    cp $filename $SCRIPTS
    chmod a+x $SCRIPTS/$filename
    echo 'cp '$filename $SCRIPTS
done

if [ -n "$1" ]; then
    ENV_NAME=$1
else
    ENV_NAME=crosscompute
fi
echo "Using ENV_NAME=$ENV_NAME"
sed -i "s/workon crosscompute/workon $ENV_NAME/" ~/.bashrc

if [ -e ~/.scripts/patch-scripts.sh ]; then
    bash ~/.scripts/patch-scripts.sh
fi

git clone --depth=1 https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall now

IPYTHON_CUSTOM_FOLDER=~/.ipython/profile_default/static/custom
mkdir -p $IPYTHON_CUSTOM_FOLDER
cp ipython/custom.* $IPYTHON_CUSTOM_FOLDER
