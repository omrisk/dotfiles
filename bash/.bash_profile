#!/bin/bash

SHELL_SHARED="$HOME/.shell-shared"

[ -r "$SHELL_SHARED" ] && source "$SHELL_SHARED"

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2>/dev/null
done

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Add tab completion for many Bash commands
if which brew &>/dev/null && [ -r "$BREW_PREFIX/etc/profile.d/bash_completion.sh" ]; then
  # Ensure existing Homebrew v1 completions continue to work
  export BASH_COMPLETION_COMPAT_DIR="$BREW_PREFIX/etc/bash_completion.d"
  source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# The Documented way to include bash completions according to brew
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && source "/usr/local/etc/profile.d/bash_completion.sh"

# Source the entire bash_completions
# confer with :{)
# for f in /usr/local/etc/bash_completion.d/*; do `source $f`; done
source /usr/local/etc/bash_completion.d/git-completion.bash

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

if ! pgrep ssh-agent &>/dev/null; then
  eval "$(ssh-agent | tee ~/.ssh/agent.env)" &>/dev/null
  ssh-add "$HOME"/.ssh/id_ed25519
else
  source ~/.ssh/agent.env &>/dev/null
fi
