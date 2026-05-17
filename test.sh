#!/bin/bash
# Validates that the dotfiles setup is working correctly.
set -euo pipefail

PASS=0
FAIL=0

check() {
  local desc="$1"
  shift
  if "$@" >/dev/null 2>&1; then
    echo "  ✓ $desc"
    PASS=$((PASS + 1))
  else
    echo "  ✗ $desc"
    FAIL=$((FAIL + 1))
  fi
}

echo "Checking plugins..."
for plugin in zsh-autosuggestions zsh-syntax-highlighting zsh-z powerlevel10k; do
  check "$plugin cloned" test -d "$HOME/.zsh/plugins/$plugin"
done

echo "Checking symlinks..."
check "~/.zshrc linked"            test -L "$HOME/.zshrc"
check "~/.aliases linked"          test -L "$HOME/.aliases"
check "~/.p10k.zsh linked"         test -L "$HOME/.p10k.zsh"
check "~/.gitconfig linked"        test -L "$HOME/.gitconfig"
check "~/.gitconfig_common linked" test -L "$HOME/.gitconfig_common"
check "~/.gitignore linked"        test -L "$HOME/.gitignore"
check "~/.tmux.conf linked"        test -L "$HOME/.tmux.conf"
check "ghostty config exists"      test -f "$HOME/.config/ghostty/config"
check "gh config exists"           test -f "$HOME/.config/gh/config.yml"

echo "Checking tools..."
check "git available"   command -v git
check "zsh available"   command -v zsh
check "fzf available"   command -v fzf
check "stow available"  command -v stow
check "nvim available"  command -v nvim

echo "Checking git config..."
check "~/.gitconfig_personal exists" test -f "$HOME/.gitconfig_personal"
check "~/.gitconfig_work exists"     test -f "$HOME/.gitconfig_work"

echo "Checking shell startup..."
STARTUP_OUTPUT=$(zsh -i -c "exit" 2>&1 || true)
if echo "$STARTUP_OUTPUT" | grep -qi "error"; then
  echo "  ✗ shell starts without errors"
  echo "    Errors found:"
  echo "$STARTUP_OUTPUT" | grep -i "error" | head -5 | sed 's/^/      /'
  FAIL=$((FAIL + 1))
else
  echo "  ✓ shell starts without errors"
  PASS=$((PASS + 1))
fi

STARTUP_TIME=$(TIMEFMT='%E'; { time zsh -i -c "exit"; } 2>&1 | tail -1)
echo "  ℹ shell startup time: ${STARTUP_TIME}"

echo ""
echo "Results: $PASS passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && exit 0 || exit 1
