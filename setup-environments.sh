if [ -n "$1" ]; then
    ENV_NAME=`basename $1`
else
    ENV_NAME=crosscompute
fi
echo "Using ENV_NAME=$ENV_NAME"
VIRTUALENV_FOLDER=~/.virtualenvs/$ENV_NAME

if command -v dnf; then
    command -v virtualenv || sudo dnf install -y python3-virtualenv
fi

if [ ! -d $VIRTUALENV_FOLDER ]; then
    virtualenv $VIRTUALENV_FOLDER -p $(which python3) --system-site-packages
fi
