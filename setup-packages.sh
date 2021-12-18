if command -v dnf; then
    command -v node || sudo dnf install -y node
    command -v npm || sudo dnf install -y npm
fi

source ~/.bashrc
v

for filename in .eslintrc.js
do
    cp $filename ~
    echo 'cp '$filename ~
done

pip install ansible-lint
pip install black
pip install flake8
pip install trash-cli

npm install -g bash-language-server
npm install -g dockerfile_lint
npm install -g eslint
npm install -g fixjson
npm install -g markdownlint
