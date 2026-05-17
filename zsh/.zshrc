zmodload zsh/datetime
_ZSHRC_START=$EPOCHREALTIME

# Powerlevel10k instant prompt — must stay at the top
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Plugins (cloned to ~/.zsh/plugins/) ---
ZSH_PLUGINS="$HOME/.zsh/plugins"
source "$ZSH_PLUGINS/powerlevel10k/powerlevel10k.zsh-theme" 2>/dev/null
source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null
source "$ZSH_PLUGINS/zsh-z/zsh-z.plugin.zsh" 2>/dev/null

# --- Exports ---
export EDITOR='nvim'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export PYTHONIOENCODING='UTF-8'

# History
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY APPEND_HISTORY

# Less
export LESS='-RMi#8j.5'
export MANPAGER='less -X'

# --- Homebrew ---
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# --- Completions ---
if [[ -d "${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh/site-functions" ]]; then
  fpath+=("${HOMEBREW_PREFIX}/share/zsh/site-functions")
fi
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}'

# --- fzf ---
if command -v fzf &>/dev/null; then
  source <(fzf --zsh 2>/dev/null) || true
fi

# pyenv PATH setup (init is handled by .forterrc)
if [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ ":$PATH:" != *":$PYENV_ROOT/bin:"* ]] && export PATH="$PYENV_ROOT/bin:$PATH"
fi

# --- Aliases ---
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# --- Work config ---
[[ -f "$HOME/.forterrc" ]] && source "$HOME/.forterrc" 2>/dev/null

# Powerlevel10k config — must stay at the bottom
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

printf '\e[2m%.0fms\e[0m\n' $(( (EPOCHREALTIME - _ZSHRC_START) * 1000 ))
unset _ZSHRC_START
