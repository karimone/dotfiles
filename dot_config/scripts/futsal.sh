export FUTSAL_PROJECT="$HOME/Code/sites/futsal"
export FUTSAL_ENV="futsal"
export FUTSAL_DB="futsal"

futsal() {
    cd $FUTSAL_PROJECT;
    pyenv activate $FUTSAL_ENV;
}

futsal-pip-compile() {
    cd $FUTSAL_PROJECT
    echo "Compile requirements.in ..."
    pip-compile requirements.in --output-file=- > requirements.txt
    echo "Compile requirements.dev.in ..."
    pip-compile requirements.dev.in --output-file=- > requirements.dev.txt
    echo "Done."
}

alias futsal-edit="vim ~/.config/scripts/futsal.sh"
alias futsal-reload="source ~/.config/scripts/futsal.sh"
alias futsal-command="futsal; DJANGO_CONFIGURATION=Dev src/manage.py"
alias futsal-shell="futsal-command shell_plus"
alias futsal-server="futsal-command runserver 0.0.0.0:8003"
alias futsal-tailwind="futsal-command tailwind start"
alias futsal-migrate="futsal-command migrate"
alias futsal-makemigrations="futsal-command makemigrations"
alias futsal-instance="ssh -i ~/.ssh/id_rsa ubuntu@alphaville.applikuapp.com"
alias futsal-clean="inv clean"
alias futsal-tests="inv run-tests"
alias futsal-install="futsal && pip install -r requirements.dev.txt"

futsal-recreate-db() {
    dropdb "$FUTSAL_DB" && createdb "$FUTSAL_DB"
}
