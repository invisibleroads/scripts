# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
# Define environment variables
if [[ ":$PATH:" != *":$HOME/.scripts:"* ]]; then
    export PATH=~/.scripts:$PATH
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
    # Go
    export GOPATH=$VIRTUAL_ENV
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
