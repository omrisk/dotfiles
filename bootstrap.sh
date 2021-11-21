#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

function do_it() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~
	source ~/.bash_profile
}

function check_and_install_homebrew() {
	which -s brew
	if [[ $? != 0 ]]; then
		# Install Homebrew
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	# Load functions from the brew script
	source ./brew.sh --source-only
	brew_update
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	do_it
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		do_it
	fi
fi

check_and_install_homebrew

unset do_it
unset check_and_install_homebrew
