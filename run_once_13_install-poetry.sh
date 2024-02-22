#!/bin/sh
# Script to install starship

os_has() {
  type "$1" > /dev/null 2>&1
}

if os_has "poetry"; then
    echo "Poetry is already installed!"
    exit
fi

if os_has "pipx"; then
   pipx install poetry
else
   echo "pipx not installed! Impossible install poetry"
fi  

