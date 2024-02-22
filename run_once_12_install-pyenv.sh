#!/bin/sh
# Script to install starship

os_has() {
  type "$1" > /dev/null 2>&1
}

if os_has "pyenv"; then
    echo "PyENV is already installed!"
    exit
fi

curl https://pyenv.run | bash && pyenv install 3.11.7 3.12.2

