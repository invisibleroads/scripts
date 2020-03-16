if [ -n "$1" ]; then
    ENV_NAME=`basename $1`
else
    ENV_NAME=crosscompute
fi
echo "Using ENV_NAME=$ENV_NAME"
VIRTUALENV_FOLDER=~/.virtualenvs/$ENV_NAME

if [ ! -d $VIRTUALENV_FOLDER ]; then
    virtualenv $VIRTUALENV_FOLDER -p $(which python3) --system-site-packages
    source $VIRTUALENV_FOLDER/bin/activate
fi
source ~/.bashrc
v

for filename in .style.yapf
do
    cp $filename ~
    echo 'cp '$filename ~
done

if command -v dnf; then
    sudo dnf install -y node npm
    sudo dnf install -y cmake gcc-c++ make python3-devel
fi

pushd ~/.vim/bundle/YouCompleteMe
python install.py --ts-completer
popd

pip install -U \
    ansible-lint \
    black \
    flake8 \
    vim-vint \
    yapf

npm install -g \
    bash-language-server \
    dockerfile_lint \
    eslint \
    fixjson \
    markdownlint
