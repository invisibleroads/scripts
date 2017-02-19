# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
# Define environment variables
if [[ ":$PATH:" != *":$HOME/.scripts:"* ]]; then
    export PATH=~/.scripts:$PATH
fi
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    export PATH=~/bin:$PATH
fi
export PS1="[\u@\h \W]\$ "
export EDITOR=vim
export PROJECTS=~/Projects
# Add aliases
alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias cdp='cd -P'
# Configure terminal
if [ -t 0 ]; then
    stty stop undef
fi
# Enter virtual environment
l() {
    export LD_LIBRARY_PATH=$VIRTUAL_ENV/lib:/usr/local/lib
    # CUDA
    export CUDA_HOME=/usr/local/cuda
    export PATH=$CUDA_HOME/bin:$PATH
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64
    # Go
    export GOPATH=$VIRTUAL_ENV
    # Node
    export NODE_PATH=/usr/lib/node_modules
}
v() {
    source ~/.virtualenvs/crosscompute/bin/activate; l
}
i() {
    v; ipython
}
n() {
    v; jupyter notebook
}
