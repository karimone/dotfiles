#!/bin/sh

os_has() {
  type "$1" > /dev/null 2>&1
}

if os_has "starship"; then
    echo "Starship already installed!"
    exit
fi

curl -sS https://starship.rs/install.sh | sh
