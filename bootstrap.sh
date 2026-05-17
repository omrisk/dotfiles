#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

PLUGINS_DIR="$HOME/.zsh/plugins"

check_and_install_homebrew() {
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  fi
  echo "Homebrew OK"
}

install_tools() {
  echo "Installing tools from Brewfile..."
  brew bundle --file=Homebrew/.Brewfile --no-lock 2>/dev/null || true

  if ! command -v stow &>/dev/null; then
    brew install stow
  fi
  echo "Tools OK"
}

install_plugins() {
  mkdir -p "$PLUGINS_DIR"

  local plugins=(
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-syntax-highlighting"
    "agkozak/zsh-z"
    "romkatv/powerlevel10k"
  )

  for plugin in "${plugins[@]}"; do
    local name="${plugin##*/}"
    local dest="$PLUGINS_DIR/$name"
    if [[ -d "$dest" ]]; then
      echo "  $name already installed"
    else
      echo "  Cloning $name..."
      git clone --depth=1 "https://github.com/$plugin.git" "$dest"
    fi
  done
  echo "Plugins OK"
}

create_dirs() {
  mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
}

link_dotfiles() {
  echo "Linking dotfiles with Stow..."
  stow --restow zsh ghostty git tmux github-cli -t "$HOME"
  echo "Stow OK"
}

set_shell() {
  local brew_zsh
  if [[ -x /opt/homebrew/bin/zsh ]]; then
    brew_zsh="/opt/homebrew/bin/zsh"
  elif [[ -x /usr/local/bin/zsh ]]; then
    brew_zsh="/usr/local/bin/zsh"
  else
    echo "Homebrew zsh not found, using system zsh"
    return
  fi

  if ! grep -Fq "$brew_zsh" /etc/shells; then
    echo "$brew_zsh" | sudo tee -a /etc/shells
  fi

  if [[ "$SHELL" != "$brew_zsh" ]]; then
    chsh -s "$brew_zsh"
    echo "Default shell set to $brew_zsh"
  fi
}

boot() {
  check_and_install_homebrew
  install_tools
  install_plugins
  create_dirs
  link_dotfiles
  set_shell
  echo ""
  echo "Done! Restart your terminal or run: exec zsh"
}

if [[ "${1:-}" == "--force" ]] || [[ "${1:-}" == "-f" ]]; then
  boot
else
  echo -n "This may overwrite existing files in your home directory. Continue? (y/n) "
  read -r REPLY
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    boot
  fi
fi
