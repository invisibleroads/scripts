# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

export SVN_EDITOR=vim
export PROJECTS=$HOME/Projects
export PYRAMID_ENV=$PROJECTS/pyramid-env
export LD_LIBRARY_PATH=$PYRAMID_ENV/lib

source $PYRAMID_ENV/bin/activate
