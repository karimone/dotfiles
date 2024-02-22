#!/bin/sh
# Script to install homebrew on mac

case "$(uname -s)" in
Darwin)
    # Macos
    type brew >/dev/null 2>&1 && echo "Homebrew already installed!" && exit
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ;;
Linux)
    # nothing to do with linux
    exit
    ;;
*)
    os_name="$(uname -s)"
    echo "Os $os_name not supported!"
    exit 1  # error!
    ;;
esac
