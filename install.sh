#!/bin/sh
export NODE_OPTIONS="--no-deprecation"

os_hasnt() {
  ! type "$1" > /dev/null 2>&1
}

check_bw(){
if os_hasnt "bw"; then

    echo "You need to install bitwarden-cli! Read the README"
    exit
fi
}


check_email() {
    if [ -z "$BW_EMAIL" ]; then
      echo "Set the email to use with bw"
      echo 'export BW_EMAIL="my@email.com'
      exit 1
    fi
}


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

check_bw
check_email
set_bw_session

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply karimone
