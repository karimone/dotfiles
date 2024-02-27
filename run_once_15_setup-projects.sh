#!/bin/sh
# Download all the projects

# Funzione per clonare il progetto solo se la directory non esiste
clone_if_not_exists() {
    local directory=$1
    local repo_url=$2
    
    if [ ! -d "$directory" ]; then
        mkdir -p "$directory"
        git clone "$repo_url" "$directory"
    else
        echo "Directory $directory already exists. Skipping clone."
    fi
}

# Clona i progetti di feex
clone_if_not_exists ~/Code/feex/mario-project git@github.com:feex-au/mario-project.git
clone_if_not_exists ~/Code/feex/campaign-website git@github.com:feex-au/campaign-website.git
clone_if_not_exists ~/Code/feex/feex-website git@github.com:feex-au/feex-website.git
clone_if_not_exists ~/Code/feex/lambda git@github.com:feex-au/lambda.git
clone_if_not_exists ~/Code/feex/feex-mobile git@github.com:feex-au/feex-mobile.git

# Clona i progetti di tools
clone_if_not_exists ~/Code/tools/kappa git@github.com:karimone/kappa.git
clone_if_not_exists ~/Code/tools/merenda git@github.com:karimone/merenda.git
clone_if_not_exists ~/Code/tools/kickstart.nvim git@github.com:karimone/kickstart.nvim.git

# Clona il progetto di sites
clone_if_not_exists ~/Code/sites/alphaville git@github.com:karimone/alphaville.git
clone_if_not_exists ~/Code/sites/karimblog git@gitlab.com:karimone/karimblog.git
clone_if_not_exists ~/Code/sites/gorjux.net git@gitlab.com:karimone/gorjux.net.git

