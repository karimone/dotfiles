#!/bin/sh

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

case "$(uname -s)" in
Darwin)
    if os_hasnt brew; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install bitwarden-cli
    ;;
Linux)
    sudo snap install bw
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac
