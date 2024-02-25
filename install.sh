#!/bin/sh
export NODE_OPTIONS="--no-deprecation"

os_hasnt() {
  ! type "$1" > /dev/null 2>&1
}

if os_hasnt "bw"; then
    echo "You need to install bitwarden-cli! Read the README"
    echo "You can install using node or the package manager"
    echo "If you are on ubuntu run sudo snap install bw"
    echo "Check the README for other methods"
    echo "https://github.com/karimone/dotfiles"
    exit
fi

if [ -z "$BW_SESSION"]; then
    echo "You must run this script with the BW_SESSION set"
    echo "Check the status with bw status"
    echo "If is unautenthicated run"
    echo 'export BW_SESSION=$(bw login EMAIL --raw)'
    echo "If is unlocked run"
    echo 'export BW_SESSION=$(bw unlock --raw)'
    exit 
fi

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply karimone
