# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
# User specific environment and startup programs
export PATH=$PATH:$HOME/.scripts
export PROJECTS=$HOME/Projects
export VIRTUAL_ENV=$HOME/.virtualenv
if [ -d $VIRTUAL_ENV ]; then
    export LD_LIBRARY_PATH=$VIRTUAL_ENV/lib
    export NODE_PATH=$VIRTUAL_ENV/lib/node_modules
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    source $VIRTUAL_ENV/bin/activate
    # Add CUDA support
    export PATH=$PATH:$VIRTUAL_ENV/opt/cuda/bin
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$VIRTUAL_ENV/opt/cuda/lib
    export CUDA_ROOT=$VIRTUAL_ENV/opt/cuda
fi
