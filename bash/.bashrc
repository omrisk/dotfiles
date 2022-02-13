#!/bin/bash
# shellcheck source="$HOME"/.bash_profile

# shellcheck disable=SC1091 # Avoid loading shellcheck with -x on unknown systems
[[ -n $PS1 ]] && source "$HOME"/.bash_profile
