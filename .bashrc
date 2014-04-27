# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
# Define environment variables
export PS1="[\u@\h \W]\$"
export PATH=$PATH:$HOME/.scripts
export EDITOR=vim
export PROJECTS=$HOME/Projects
# Add aliases
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias cdp='cd -P'
alias xclip='xclip -selection c'
# Configure terminal
stty stop undef
# Enter virtual environment
v() {
    export WORKON_HOME=$HOME/.virtualenvs
    source virtualenvwrapper.sh
    workon crosscompute
    export LD_LIBRARY_PATH=$VIRTUAL_ENV/lib
    export NODE_PATH=$VIRTUAL_ENV/lib/node_modules
    # Add CUDA support
    # export PATH=$PATH:$VIRTUAL_ENV/opt/cuda/bin
    # export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$VIRTUAL_ENV/opt/cuda/lib
    # export CUDA_ROOT=$VIRTUAL_ENV/opt/cuda
}
# Start IPython
i() {
    v
    ipython
}
# Start IPython notebook
n() {
    v
    ipython notebook
}
