if command -v dnf; then
    command -v node || sudo dnf install -y node
    command -v npm || sudo dnf install -y npm
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
    dockerfile_lint \
    eslint \
    eslint-config-standard \
    eslint-plugin-import \
    eslint-plugin-node \
    eslint-plugin-promise \
    eslint-plugin-standard \
    fixjson \
    markdownlint
