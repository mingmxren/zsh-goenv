GOENV_ROOT="${HOME}/.goenv"
_zsh_goenv_repo="https://github.com/go-nv/goenv.git"

zsh-goenv-install() {
    if [[ ! -d "${GOENV_ROOT}" ]]; then
        git clone "${_zsh_goenv_repo}" "${GOENV_ROOT}"
    elif [[ ! -d "${GOENV_ROOT}/.git" ]]; then
        git -C "${GOENV_ROOT}" init
        git -C "${GOENV_ROOT}" remote add origin "${_zsh_goenv_repo}"
        git -C "${GOENV_ROOT}" pull origin HEAD
    fi
}

zsh-goenv-upgrade() {
    if [[ ! -d "${GOENV_ROOT}" ]]; then
        echo "goenv not installed"
        return 1
    fi
    if [[ ! -d "${GOENV_ROOT}/.git" ]]; then
        echo "goenv not installed with git"
        return 1
    fi
    echo "upgrading goenv..."
    git -C "${GOENV_ROOT}" pull origin HEAD
}

zsh-goenv-install

# add goenv to path
path=("${GOENV_ROOT}/bin" "${GOENV_ROOT}/shims" $path)
# set GOENV_GOPATH_PREFIX if empty
if [[ -z "${GOENV_GOPATH_PREFIX}" ]]; then
    export GOENV_GOPATH_PREFIX="${HOME}/.gopath"
fi

export GOENV_GOMOD_VERSION_ENABLE=1

eval "$(goenv init -)"

# add go to path
if [[ "$GOPATH" != "" ]];then
    export path=("$GOPATH/bin" $path)
elif [[ "$(go env GOPATH)" != "" ]];then
    export path=("$(go env GOPATH)/bin" $path)
fi
