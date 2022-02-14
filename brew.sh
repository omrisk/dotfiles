#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Set Homebrew params
export HOMEBREW_BREWFILE="$HOME/.brewfile"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

function commit_brewfile() {
  # Ensure we don't commit stuff we don't want
  git stash

  DATE=$(date "+%Y-%m-%d-%H-%M")
  git checkout -b brew-file-update-"$DATE"
  # Backup and save the updated BREW packages, overwrite the repositories '.Brewfile'
  brew bundle dump --file=./.Brewfile --force

  git add .Brewfile
  git commit --include .Brewfile -m "chore(brew): Updating brew packages for $DATE"

  # Push the changes
  gh pr create --title "Brewfile update" -b "This was opened by using the 'update-brew.sh' script."

  # Restore the localbranch to the pre-update state
  git checkout -
  git stash pop
}

function brew_update() {
  # Make sure we’re using the latest Homebrew.
  brew update

  # Upgrade any already-installed formulae.
  brew upgrade

  brew bundle --global

  # Install GNU core utilities (those that come with macOS are outdated).
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
  ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

  # Remove outdated versions from the cellar.
  brew cleanup
}

function print_help() {
  echo "Help blurb!"
  echo "-b - Create a .Brewfile based off the locally installed brew formulae and open a github pull request to commit it"
  echo "-u - Update brew and install any packages in the global .Brewfile"
  echo "-h - Print this help blurb"
}

function main() {
  if [ "$#" -eq 0 ]; then
    echo "No parameters passed, see this helpful help blurb:"
    print_help
  fi

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
      print_help
      exit 0
      ;;
    *)
      echo "invalid flag!"
      print_help
      exit 0
      ;;
    esac
  done

}

if [[ ${1} != "--source-only" ]]; then
  main "${@}"
fi
