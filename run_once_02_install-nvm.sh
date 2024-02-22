#!/bin/sh
# Script to install nvm

NVM_VERSION="v0.39.7"

os_has() {
  type "$1" > /dev/null 2>&1
}


if os_has "nv"; then
    echo "NVM already installed!"
    exit
fi


# install NVM
if os_has "curl"; then
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash"
elif os_has "wget"; then
    wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash"
else
    echo "Missing wget or curl!"
    exit 1  # error!
fi


# setup the last lts and use it as default
nvm install --lts
nvm alias default stable

