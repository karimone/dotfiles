#!/bin/sh
# Script to install homebrew on mac

type git >/dev/null 2>&1 && echo "Git already installed!" && exit

case "$(uname -s)" in
Darwin)
    # Macos
    brew install git
    exit
    ;;
Linux)
    sudo apt update && sudo apt upgrade -y && sudo apt install -y git
    exit
    ;;
*)
    os_name="$(uname -s)"
    echo "Os $os_name not supported!"
    exit 1  # error!
    ;;
esac
