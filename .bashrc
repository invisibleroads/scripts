# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
# Define environment variables
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH=~/.local/bin:$PATH
fi
if [[ ":$PATH:" != *":$HOME/.scripts:"* ]]; then
    export PATH=~/.scripts:$PATH
fi
export LANG=C.UTF-8
export PS1="[\u@\h \W]\$ "
export EDITOR=vim
export PROJECTS=~/Projects
export BASH_SILENCE_DEPRECATION_WARNING=1
# Add aliases
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias ls='ls --color=auto'
    alias ll='ls -l'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -G'
    alias ll='ls -l'
fi
# If we are in a terminal, free CTRL-S and CTRL-Q
if [ -t 0 ]; then
    stty start undef
    stty stop undef
fi
# Enter virtual environment
v() {
    source ~/.virtualenvs/crosscompute/bin/activate
    export LD_LIBRARY_PATH=$VIRTUAL_ENV/lib:/usr/local/lib
    # CUDA
    export CUDA_HOME=/usr/local/cuda
    export PATH=$CUDA_HOME/bin:$PATH
    export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
    # Go
    export GOPATH=$VIRTUAL_ENV
    # Node
    export NODE_PATH=$VIRTUAL_ENV/lib/node_modules
    export NPM_CONFIG_PREFIX=$VIRTUAL_ENV
    # Jupyter
    export JUPYTER_PLATFORM_DIRS=1
    # pudb
    export PUDB_RDB_REVERSE=1
}
