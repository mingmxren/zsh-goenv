GOENV_HOME="${${(%):-%x}:A:h}/goenv"

goenv-install() {
    echo "installing goenv..."
    if [[ ! -d "${GOENV_HOME}" ]]; then
        git clone "https://github.com/go-nv/goenv.git" "${GOENV_HOME}"
    else
        echo "goenv already installed"
        return 1
    fi
}

goenv-upgrade() {
    if [[ ! -d "${GOENV_HOME}" ]]; then
        echo "goenv not installed"
        return 1
    else
        echo "upgrading goenv..."
        cd "${GOENV_HOME}"
        git pull
    fi
}

if [[ ! -d "${GOENV_HOME}" ]]; then
    goenv-install
fi

# add goenv to path
path+=( "${GOENV_HOME}/bin" )
export GOENV_ROOT="$HOME/.goenv"
eval "$(goenv init -)"