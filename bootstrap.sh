#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

function do_it() {

  if which -s stow; then
    check_and_install_homebrew
  fi
  # shellcheck disable=SC2035 # Stow doesn't know how to resolve -- when globing
  stow --restow */
  source "$HOME"/.bash_profile
}

function check_and_install_homebrew() {
  if which -s brew; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Load functions from the brew script
  source ./brew.sh --source-only
  brew_update
}

if [[ $1 == "--force" ]] || [[ $1 == "-f" ]]; then
  do_it
else
  read -pr "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    do_it
  fi
fi

read -pr "Do you want to update homebrew packages? (y/n)" -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  check_and_install_homebrew
fi

unset do_it
unset check_and_install_homebrew
