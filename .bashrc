# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
# Define environment variables
export PS1="[\u@\h \W]\$ "
export PATH=~/.scripts:$PATH
export EDITOR=vim
export PROJECTS=~/Projects
# Add aliases
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias cdp='cd -P'
# Configure terminal
if [ -t 0 ]; then
    stty stop undef
fi
# Enter virtual environment
l() {
    export LD_LIBRARY_PATH=$VIRTUAL_ENV/lib:/usr/local/lib
    # Go
    export GOPATH=$VIRTUAL_ENV
    # Node
    export NODE_PATH=$VIRTUAL_ENV/lib/node_modules
    # CUDA
    export CUDA_HOME=/usr/local/cuda
    export PATH=$CUDA_HOME/bin:$PATH
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64
}
v() {
    source ~/.virtualenvs/crosscompute/bin/activate; l
}
p() {
    source ~/.virtualenvs/python3/bin/activate; l
}
b() {
    v; bpython
}
i() {
    v; ipython
}
n() {
    v; jupyter notebook
}
