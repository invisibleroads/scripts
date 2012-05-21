# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
# User specific environment and startup programs
export PATH=$PATH:$HOME/.scripts
export PROJECTS=$HOME/Projects
export VIRTUAL_ENV_DISABLE_PROMPT=1
. e
