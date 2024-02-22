#!/bin/sh
# Script to install starship

os_has() {
  type "$1" > /dev/null 2>&1
}

if os_has "pyenv"; then
    echo "PyENV is already installed!"
    exit
fi

curl https://pyenv.run | bash

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)
