#!/bin/bash

cd "$(dirname "$0")" || exit

function boot() {
  if ! which -s stow &>/dev/null; then
    check_and_install_homebrew
  fi

  # shellcheck disable=SC2035 # Stow doesn't know how to resolve -- when globing
  stow --restow */ -t "$HOME"

  # Switch to using brew-installed bash as default shell
  # if ! grep -F -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  #   echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells
  #   # Uncomment the next line to use bash
  #   # chsh -s "${BREW_PREFIX}/bin/bash"
  # fi
}

function check_and_install_homebrew() {
  if ! which -s brew &>/dev/null; then
    # Install Homebrew
    eval "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Load functions from the brew script
  source brew.sh --source-only
  brew_update
}

if [[ $1 == "--force" ]] || [[ $1 == "-f" ]]; then
  boot
else
  echo -n "This may overwrite existing files in your home directory. Are you sure? (y/n) "
  read -r REPLY
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    boot
  fi
fi

unset boot
unset check_and_install_homebrew
