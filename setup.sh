#!/bin/bash
cd $(dirname "$0")

SCRIPTS=~/.scripts
if [ ! -e $SCRIPTS ]; then
    mkdir $SCRIPTS
fi

for filename in .bash_profile .bashrc .tmux.conf .vimrc
do
    cp $filename ~
    echo 'cp '$filename ~
done

for filename in clean git-status grep- *.py
do
    cp $filename $SCRIPTS
    chmod a+x $SCRIPTS/$filename
    echo 'cp '$filename $SCRIPTS
done

if [ -n "$1" ]; then
    ENV_NAME=`basename $1`
else
    ENV_NAME=crosscompute
fi
echo "Using ENV_NAME=$ENV_NAME"
sed -i "s/.virtualenvs\/crosscompute/.virtualenvs\/$ENV_NAME/" ~/.bashrc

VUNDLE_FOLDER=~/.vim/bundle/Vundle.vim
if [ ! -d $VUNDLE_FOLDER ]; then
    git clone --depth=1 https://github.com/gmarik/Vundle.vim.git $VUNDLE_FOLDER
else
    pushd $VUNDLE_FOLDER
    git pull
    popd
fi
vim +PluginInstall +qall now &>/dev/null || true