# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# User specific aliases and functions
cc() {
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
    workon crosscompute
    cd $PROJECTS/crosscompute
    export LD_LIBRARY_PATH=$VIRTUAL_ENV/lib
    export NODE_PATH=$VIRTUAL_ENV/lib/node_modules
    # Add CUDA support
    export PATH=$PATH:$VIRTUAL_ENV/opt/cuda/bin
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$VIRTUAL_ENV/opt/cuda/lib
    export CUDA_ROOT=$VIRTUAL_ENV/opt/cuda
}
