#!/bin/bash
export ZSH="${HOME}/.oh-my-zsh"
export ZSH_THEME="robbyrussell"
export GITHUB_OWNER="neuralnetes"
export GITHUB_REPOSITORY="${GITHUB_OWNER}/monorepo"
export GITHUB_WORKSPACE="${HOME}/go/src/github.com/${GITHUB_REPOSITORY}"
export GITHUB_USER="lerms"
export GITHUB_USER_WORKSPACE="${GITHUB_WORKSPACE}/bash/workspace/${GITHUB_USER}"
export GITHUB_REF=$(cd "${GITHUB_WORKSPACE}" && git branch --show-current)
export GITHUB_SHA=$(cd "${GITHUB_WORKSPACE}" && git rev-parse HEAD)
export plugins=(
    git
    kubectl
    terraform
    direnv
    pyenv
    python
    gcloud
    aws
    fzf
    nvm
)
ln -fs "${GITHUB_USER_WORKSPACE}"/* "${HOME}"
ln -fs "${GITHUB_USER_WORKSPACE}"/.envrc* "${GITHUB_WORKSPACE}"
source "${ZSH}/oh-my-zsh.sh"
source "${HOME}/.function"
source "${HOME}/.alias"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/alexanderlerma/go/src/github.com/neuralnetes/monorepo/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/alexanderlerma/go/src/github.com/neuralnetes/monorepo/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/alexanderlerma/go/src/github.com/neuralnetes/monorepo/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/alexanderlerma/go/src/github.com/neuralnetes/monorepo/google-cloud-sdk/completion.zsh.inc'; fi
