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

  for tool in stow fzf neovim; do
    if ! command -v "${tool%neovim}${tool#neovim}" &>/dev/null 2>&1; then
      brew install "$tool" 2>/dev/null || true
    fi
  done
  echo "Tools OK"
}

install_font() {
  if ! ls ~/Library/Fonts/MesloLGS*NF* &>/dev/null 2>&1 && \
     ! ls /Library/Fonts/MesloLGS*NF* &>/dev/null 2>&1; then
    echo "Installing MesloLGS Nerd Font..."
    brew install --cask font-meslo-lg-nerd-font 2>/dev/null || true
  fi
  echo "Font OK"
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

setup_git_configs() {
  if [[ ! -f "$HOME/.gitconfig_personal" ]]; then
    echo "Creating ~/.gitconfig_personal template..."
    cat > "$HOME/.gitconfig_personal" <<'GITEOF'
[user]
  name = YOUR NAME
  email = YOUR EMAIL
GITEOF
    echo "  ⚠ Edit ~/.gitconfig_personal with your name and email"
  fi

  if [[ ! -f "$HOME/.gitconfig_work" ]]; then
    cat > "$HOME/.gitconfig_work" <<'GITEOF'
[user]
  name = YOUR WORK NAME
  email = YOUR WORK EMAIL
GITEOF
    echo "  ⚠ Edit ~/.gitconfig_work with your work name and email"
  fi
}

link_dotfiles() {
  echo "Linking dotfiles with Stow..."
  # Remove existing files that would conflict with symlinks
  for f in .zshrc .aliases .p10k.zsh .gitconfig .gitconfig_common .gitignore .tmux.conf; do
    if [[ -f "$HOME/$f" && ! -L "$HOME/$f" ]]; then
      echo "  Backing up ~/$f to ~/${f}.bak"
      mv "$HOME/$f" "$HOME/${f}.bak"
    fi
  done
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
  install_font
  install_plugins
  create_dirs
  link_dotfiles
  setup_git_configs
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
