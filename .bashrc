# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
# Define environment variables
export PS1="[\u@\h \W]\$ "
export PATH=$PATH:~/.scripts:~/bin
export EDITOR=vim
export PROJECTS=~/Projects
export VIRTUALENVWRAPPER_PYTHON=`which python2.7`
# Add aliases
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias cdp='cd -P'
alias xclip='xclip -selection c'
# Configure terminal
if [ -t 0 ]; then
    stty stop undef
fi
# Enter virtual environment
v() {
    export WORKON_HOME=~/.virtualenvs
    source virtualenvwrapper.sh
    workon crosscompute
    export LD_LIBRARY_PATH=$VIRTUAL_ENV/lib:/usr/local/lib
    export NODE_PATH=$VIRTUAL_ENV/lib/node_modules
    # Add CUDA support
    export CUDA_ROOT=/usr/local/cuda
    export PATH=$PATH:$CUDA_ROOT/bin
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64
}
# Start IPython
i() {
    v; ipython
}
# Start IPython notebook
n() {
    v; ipython notebook
}
