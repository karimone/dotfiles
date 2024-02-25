#!/bin/sh

os_has() {
  type "$1" > /dev/null 2>&1
}

if os_has "bw"; then
    export BW_SESSION=$(bw login --raw)
else
    echo "You need to install BW!"
    echo "Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    source ~/.bashrc
    nvm install stable
    nvm use stable
    export NODE_OPTIONS="--no-deprecation"
    npm install -g @bitwarden/cli
fi

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply karimone
