#!/bin/sh
# Script to install nvm

os_has() {
  type "$1" > /dev/null 2>&1
}

nvm_setup() {
    # setup the last lts and use it as default
    # not used at the moment
    nvm install --lts
    nvm alias default stable
}

if os_has "nvm"; then
    echo "NVM already installed!"
    exit
else
    wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash"
fi





