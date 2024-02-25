#!/bin/sh
os_hasnt() {
  ! type "$1" > /dev/null 2>&1
}

if os_hasnt "bw"; then
    echo """
You need to install bitwarden-cli!

Install using the following line
Then follow the instructions to load the nvm

---
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
---

Then:

nvm install stable
nvm use stable
npm install -g @bitwarden/cli
export NODE_OPTIONS="--no-deprecation"

And run again the script
"""
    exit 1
fi


export NODE_OPTIONS="--no-deprecation"

if [ -z "$BW_EMAIL" ]; then
  # Check if the input is a valid email
  while ! [ "$(echo "$BW_EMAIL" | grep '^[a-zA-Z0-9._%+-]\+@[a-zA-Z0-9.-]\+\.[a-zA-Z]\{2,\}$')" ]; do
    read -p "Enter your email address: " BW_EMAIL
    export BW_EMAIL
  done
fi

set_bw_session() {
    while [ -z "$BW_SESSION" ]; do
        bw_status=$(bw status | jq -r '.status' 2>/dev/null)

        if [ "$?" -eq 0 ]; then
            case "$bw_status" in
                "unauthenticated")
                    echo "Logging in..."
                    export BW_SESSION=$(bw login $BW_EMAIL --raw)
                    exit 1
                    ;;
                "locked")
                    echo "Vault is locked. Unlocking..."
                    export BW_SESSION=$(bw unlock --raw)
                    ;;
                "unlocked")
                    echo "Vault is already unlocked."
                    ;;
                *)
                    echo "Unknown status: $bw_status. Exiting."
                    exit 1
                    ;;
            esac
        else
            echo "Error checking Bitwarden status. Retrying..."
            sleep 1
        fi
    done
}
