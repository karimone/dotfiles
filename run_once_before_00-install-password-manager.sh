#!/bin/sh
type bw >/dev/null 2>&1 && echo "Bitwarden already installed!" && exit

case "$(uname -s)" in
Darwin)
    # Macos
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install bitwarden-cli
    ;;
Linux)
    arch=$(uname -m)

    if [ $arch = "aarch64" ]; then
        sudo apt install build-essential
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        . ~/.nvm/nvm.sh
        . ~/.profile
        . ~/.bashrc
        nvm install stable
        nvm use stable
        npm install -g @bitwarden/cli
    else
        sudo snap install bw
    fi

    ;;
*)
    os_name="$(uname -s)"
    echo "Os $os_name not supported!"
    exit 1  # error!
    ;;
esac
