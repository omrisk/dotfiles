[ -n "$PS1" ] && source ~/.bash_profile

FILE="~/.forterrc"
if [[ -f "$FILE" ]]; then
    echo "Sourcing work rc"
    source $FILE
fi
