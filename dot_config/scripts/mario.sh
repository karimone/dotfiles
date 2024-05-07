export MARIO_PROJECT="$HOME/Code/feex/mario-project"
export MARIO_ENV="feex"
export MARIO_DB="mario"

# Mario stuff

mario() {
    cd $MARIO_PROJECT;
    pyenv activate mario;
}

mario-pip-compile() {
    cd $MARIO_PROJECT
    echo "Compile requirements.in ..."
    pip-compile requirements.in --output-file=- > requirements.txt
    echo "Compile requirements.dev.in ..."
    pip-compile requirements.dev.in --output-file=- > requirements.dev.txt
    echo "Done."
}

alias m="mario"
alias me="vim ~/.config/scripts/mario.sh"
alias re="source ~/.config/scripts/mario.sh"
alias mario-command="mario; DJANGO_CONFIGURATION=Local src/manage.py"
alias mc="mario-command"
alias mario-shell="mario-command shell_plus"
alias mario-server="mario-command runserver 0.0.0.0:8003"
alias mario-tailwind="mario-command tailwind start"
alias mario-migrate="mario-command migrate"
alias mario-makemigrations="mario-command makemigrations"
alias mario-instance="ssh -i ~/.ssh/id_rsa ubuntu@app.feex.com.au"
alias mario-clean="inv clean"
alias mario-tests="inv run-tests"
alias mario-install="mario && pip install -r requirements.dev.txt"

mario-recreate-db() {
    dropdb "$MARIO_DB" && createdb "$MARIO_DB"
}

mario-recreate-migrations(){
    mario; 
    rm src/**/migrations/0*.py
    mario-makemigrations
    mario-migrate
}


mario-recreate() {
    mario-recreate-db;
    mario-recreate-migrations;
    mario-command seed_db --not-dry-run
}



mario-deploy(){
    mario;
    cd "$MARIO_ANSIBLE" 
    echo "Deploying Mario ..."
    ansible-playbook --ssh-extra-args=-A -i development site.yml --tags=deploy
    cd -
}
