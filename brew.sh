#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Set Homebrew params
export HOMEBREW_BREWFILE="~/.brewfile"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)


commit_brewfile(){
  # Ensure we don't commit stuff we don't want
  git stash

  # Backup and save the updated BREW packages, overwrite the repositories '.Brewfile'
  brew bundle dump --file=./.Brewfile --force

  git commit --include .Brewfile -m "Updating brew packages"

  # Push the changes
  gh pr create --title "Brewfile update" -b "This was opened by using the 'update-brew.sh' script."

  # Restore the localbranch to the pre-update state
  git stash pop
}

brew_update(){
  # Make sure we’re using the latest Homebrew.
  brew update

  # Upgrade any already-installed formulae.
  brew upgrade

  brew bundle --global

  # Install GNU core utilities (those that come with macOS are outdated).
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.

  ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"


  # Switch to using brew-installed bash as default shell
  if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
    echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
    chsh -s "${BREW_PREFIX}/bin/bash";
  fi;

  # Remove outdated versions from the cellar.
  brew cleanup
}


while getopts ":buh" opt; do
  case $opt in
    b)
      echo "Backing up brew accoriding to output from 'brew bundle dump'"
      commit_brewfile
      exit 0   
      ;;
    u)
      echo "Installing and updating brew formulae"
      brew_update
      exit 0   
      ;;
    h)
      echo "Help blurb!"
      echo "-b - Create a .Brewfile based off the locally installed brew formulae and open a github pull request to commit it"
      echo "-u - Update brew and install any packages in the global .Brewfile"
      exit 0
      ;;
    *)
      echo "Default running the update/upgrade (like you passed '-u' to this script)"
      exit 0
      ;;
  esac
done