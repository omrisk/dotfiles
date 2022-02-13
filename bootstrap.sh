#!/bin/bash

cd "$(dirname "$0")" || exit

function boot() {
  if ! which -s stow &>/dev/null; then
    check_and_install_homebrew
  fi

  # Ensure zsh is installed and is default shell
  if [[ $SHELL != *"zsh"* ]]; then
    source zsh.sh
  fi

  # shellcheck disable=SC2035 # Stow doesn't know how to resolve -- when globing
  stow --restow */
}

function check_and_install_homebrew() {
  if which -s brew &>/dev/null; then
    # Install Homebrew
    eval "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Load functions from the brew script
  source ./brew.sh --source-only
  brew_update
}

if [[ $1 == "--force" ]] || [[ $1 == "-f" ]]; then
  boot
else
  read -r -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    boot
  fi
fi

unset boot
unset check_and_install_homebrew
