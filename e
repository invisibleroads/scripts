source $PROJECTS/pyramid-env/bin/activate
pushd $PROJECTS
export LD_LIBRARY_PATH=$VIRTUAL_ENV/lib
export NODE_PATH=$VIRTUAL_ENV/lib/node_modules
