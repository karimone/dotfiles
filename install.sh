#!/bin/sh

os_hasnt() {
  ! type "$1" > /dev/null 2>&1
}

print_green_frame() {
  printf "\e[1;32m+%s+\e[0m\n" "$(printf -- '-%.0s' {1..50})"
}

print_green() {
  printf "\e[1;32m%s\e[0m\n" "$1"
}

print_yellow_frame() {
  printf "\e[1;33m+%s+\e[0m\n" "$(printf -- '-%.0s' {1..50})"
}

print_yellow() {
  printf "\e[1;33m%s\e[0m\n" "$1"
}

print_red_frame() {
  printf "\e[1;31m+%s+\e[0m\n" "$(printf -- '-%.0s' {1..50})"
}

print_red() {
  printf "\e[1;31m%s\e[0m\n" "$1"
}

if os_hasnt "bw"; then
    print_red_frame
    print_red "You need to install bitwarden-cli! Read the README"
    print_yellow "You can install it using Node.js or your package manager"
    print_yellow "If you are on Ubuntu, run:"
    print_yellow "  sudo snap install bw"
    print_yellow "Or use Node.js and install the package directly:"
    print_yellow "  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash"
    print_yellow "Then reload the shell to update the paths and other settings"
    print_yellow "  nvm install stable && nvm use stable"
    print_yellow "  npm install -g @bitwarden/cli"
    print_yellow '  export NODE_OPTIONS="--no-deprecation"'
    print_yellow "Check the README for more details:"
    print_yellow "https://github.com/karimone/dotfiles"
    print_red_frame
    exit
fi

if [ -z "$BW_SESSION" ]; then
    print_red_frame
    print_red "You must run this script with the BW_SESSION set"
    print_yellow "Check the status with:"
    print_yellow "  bw status"
    print_yellow "If it is unauthenticated, run:"
    print_yellow '  export BW_SESSION=$(bw login [BW_EMAIL] --raw)'
    print_yellow "If it is unlocked, run:"
    print_yellow '  export BW_SESSION=$(bw unlock --raw)'
    print_yellow "You can also set the Bitwarden email:"
    print_yellow '  export BW_EMAIL="your@email.com"'
    print_yellow "And run the script again. (It will ask for the master password)"
    print_red_frame
    exit 
fi

# Esegui lo script Chezmoi
print_green_frame
print_green "Running Chezmoi Script..."
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply karimone
print_green_frame

print_green "All done!"

