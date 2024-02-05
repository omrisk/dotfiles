# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

SHELL_SHARED="$HOME/.shell-shared"
[ -f "$SHELL_SHARED" ] && source "$SHELL_SHARED" > /dev/null

export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  common-aliases
  docker
  extract
  fzf
  git
  gitignore
  mvn
  sbt
  timer
  tmux
  vi-mode
  vscode
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
)

ZSH_THEME="powerlevel10k/powerlevel10k"
source "$ZSH"/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias ohmyzsh="nvim ~/.oh-my-zsh"

# if which nvim &>/dev/null; then
#   alias v="nvim"
#   alias vim="nvim"
#   EDITOR="/usr/local/bin/nvim"
# else
#   EDITOR "/usr/bin/vim"
#   alias v="vim"
# fi

# default settings for less. You may also want to disable line wrapping with -S
LESS='-NXMRi#8j.5'
#      |||||||
#      |||||| `- center on search matches
#      |||||`--- scroll horizontally 8 columns at a time
#      ||||`---- case-insensitive search unless pattern contains uppercase
#      |||`----- parse color codes
#      ||`------ show more information in prompt
#      |`------ don't wipe the less output on exit
#      `------- show line numbers

# shell history is useful, let's have more of it
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTFILE=~/.cache/zsh/history
HISTCONTROL=ignoredups   # don't store duplicated commands
#shopt -s histappend   # don't overwrite history file after each session

# vi-mode settings
VI_MODE_SET_CURSOR=true

# Use vim keys instead of arrows in menuselect
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^?' backward-delete-char

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /Users/omri_keefe/.forterrc
