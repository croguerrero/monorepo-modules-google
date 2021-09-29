#!/bin/bash
function setup_pyenv() {
  if [[ ! -d "${PYENV_ROOT}" ]]; then
    git clone https://github.com/pyenv/pyenv.git "${PYENV_ROOT}"
    cd "${PYENV_ROOT}" && bash src/configure && make -C src
  fi
}

function setup_pyenv_virtualenv() {
  if [[ ! -d "${PYENV_ROOT}/plugins/pyenv-virtualenv" ]]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git "${PYENV_ROOT}/plugins/pyenv-virtualenv"
  fi
}
