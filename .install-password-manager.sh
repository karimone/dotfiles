#!/bin/sh
# version that is common for every os

os_has() {
  type "$1" > /dev/null 2>&1
}

os_hasnt() {
  type "$1" > /dev/null 2>&1 || return 0
  return 1
}

if os_has "bw"; then
    echo "Bitwarden already installed."
    exit;
fi

if os_hasnt "nvm"; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    nvm install node
    nvm use node
fi

if os_hasnt "npm"; then
    npm install -g @bitwarden/cli
fi
esac
