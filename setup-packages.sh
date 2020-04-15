if [ -n "$1" ]; then
    ENV_NAME=`basename $1`
else
    ENV_NAME=crosscompute
fi
echo "Using ENV_NAME=$ENV_NAME"
VIRTUALENV_FOLDER=~/.virtualenvs/$ENV_NAME

if command -v dnf; then
    command -v node || sudo dnf install -y node
    command -v npm || sudo dnf install -y npm
    command -v virtualenv || sudo dnf install -y python3-virtualenv
fi

if [ ! -d $VIRTUALENV_FOLDER ]; then
    virtualenv $VIRTUALENV_FOLDER -p $(which python3) --system-site-packages
    source $VIRTUALENV_FOLDER/bin/activate
fi
source ~/.bashrc
v

for filename in .eslintrc.js .style.yapf
do
    cp $filename ~
    echo 'cp '$filename ~
done

pip install -U \
    ansible-lint \
    black \
    flake8 \
    vim-vint \
    yapf

npm install -g \
    bash-language-server \
    dockerfile-lint \
    eslint \
    eslint-config-standard \
    eslint-plugin-import \
    eslint-plugin-node \
    eslint-plugin-promise \
    eslint-plugin-standard \
    fixjson \
    markdownlint
