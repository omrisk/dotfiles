# Changelog

All notable changes to this dotfiles repository.

## [Unreleased]

### Added
- **Ghostty terminal configuration** - Ultra-fast, native macOS terminal setup
  - Solarized Dark theme
  - MesloLGS NF font configuration
  - Native macOS keybindings (Cmd+C/V/N/W)
  - 95% window opacity
- **Comprehensive terminal documentation** - Complete guide in `TERMINAL_SETUP.md`
- **Terminal readiness check** - Ensures tmux only starts when terminal is fully initialized
- **TPM existence check** - tmux config now checks if plugin manager exists before loading

### Changed
- **bootstrap.sh fixes:**
  - Fixed inverted Homebrew installation logic
  - Replaced bash-specific `read` flags with portable version for zsh compatibility
- **zsh.sh improvements:**
  - Fixed critical bug: now correctly sets zsh as default shell (was setting bash)
  - Added BREW_PREFIX auto-detection for Apple Silicon and Intel Macs
  - Added idempotency checks for all plugin installations
  - Fixed typo: "defualt" → "default"
- **tmux configuration optimizations:**
  - Changed terminal type from `screen-256color` to `tmux-256color`
  - Added true color support for modern terminals (Ghostty, iTerm2, etc.)
  - Increased scrollback buffer from 2,000 to 50,000 lines
  - Reduced escape time from 10ms to 0ms for instant vim responsiveness
  - Added focus events for better Vim/Neovim integration
  - Remove CLAUDECODE environment variable to allow Claude Code in tmux sessions
- **zsh auto-start tmux:**
  - Added intelligent tmux auto-start with proper conditions
  - Skips SSH connections, VS Code terminals, and nested tmux
  - Added terminal readiness check to prevent startup errors

### Fixed
- **Shell initialization errors:**
  - Fixed node version manager (n) verbose output in `.forterrc`
  - Fixed jenv plugin "already enabled" error in `.shell-shared`
  - Removed duplicate pyenv initialization
  - Fixed GPG tty setup producing "not a terminal" error in `.exports`
  - Added stderr suppression for all sourced dotfiles
- **tmux startup errors:**
  - Fixed "open terminal failed: not a terminal" by adding terminal readiness check
  - Added conditional TPM loading to prevent errors when plugin manager isn't installed

### Technical Details

#### bootstrap.sh (lines 22, 35-36)
```bash
# Before: if which -s brew &>/dev/null; then
# After:  if ! which -s brew &>/dev/null; then

# Before: read -r -p "prompt" -n 1
# After:  echo -n "prompt" && read -r REPLY
```

#### zsh.sh (line 17, 3-11)
```bash
# Before: chsh -s "${BREW_PREFIX}/bin/bash"
# After:  chsh -s "${BREW_PREFIX}/bin/zsh"

# Added BREW_PREFIX detection for both architectures
```

#### .forterrc (line 58)
```bash
# Before: n v16
# After:  n v16 > /dev/null 2>&1
```

#### .shell-shared (lines 8-10, 16-21, 30-34)
```bash
# Added stderr suppression to sourced files
source "$file" 2>/dev/null

# Fixed jenv plugin check
if ! jenv plugins 2>/dev/null | grep -q "^export$"; then
  jenv enable-plugin export &>/dev/null || true
fi

# Removed duplicate pyenv init
```

#### bash/.exports (line 34)
```bash
# Before: DEV_TTY=$(tty)
# After:  DEV_TTY=$(tty 2>/dev/null)
```

#### tmux/.tmux.conf (lines 23-30, 54-59, 112)
```bash
# Changed terminal type
set-option -g default-terminal "tmux-256color"

# Added true color support
set -g terminal-overrides ',xterm-256color:RGB'

# Performance improvements
set-option -g history-limit 50000
set-option -sg escape-time 0

# Conditional TPM loading
if-shell "[ -f ~/.tmux/plugins/tpm/tpm ]" "run -b '~/.tmux/plugins/tpm/tpm'"
```

#### zsh/.zshrc (lines 9-15, 125-132, 134-138)
```bash
# Added interactive shell detection for verbose output
if [[ $- == *i* ]]; then
  source "$SHELL_SHARED"
else
  source "$SHELL_SHARED" > /dev/null 2>&1
fi

# Added terminal readiness check for tmux
if [ -t 0 ] && [ -t 1 ]; then
  tmux attach -t default 2>/dev/null || tmux new -s default
fi

# Suppress forterrc errors
source /Users/omri_keefe/.forterrc 2>/dev/null
```

---

## Key Benefits

### Performance
- **Faster startup**: 0ms tmux escape time
- **Better scrollback**: 50,000 lines for debugging
- **GPU acceleration**: Ghostty rendering

### Reliability
- **Clean startup**: No errors or warnings
- **Session persistence**: Work survives restarts
- **Cross-platform**: Works on Apple Silicon and Intel

### Developer Experience
- **Agent development ready**: Large scrollback for logs
- **Vim-friendly**: Instant escape, proper focus events
- **Native integration**: macOS-native terminal experience

---

## Migration Notes

### From Previous Setup

If upgrading from the old configuration:

1. **Backup existing sessions:**
   ```bash
   tmux list-sessions
   # Note any important sessions
   ```

2. **Kill tmux server:**
   ```bash
   tmux kill-server
   ```

3. **Apply new configs:**
   ```bash
   cd ~/dev/dotfiles
   stow --restow tmux zsh shell-shared bash -t "$HOME"
   ```

4. **Install Ghostty:**
   ```bash
   brew install --cask ghostty
   stow --restow ghostty -t "$HOME"
   ```

5. **Restart terminal**

### Breaking Changes

None - all changes are backward compatible. The setup works with:
- Default Terminal.app
- iTerm2
- Ghostty (recommended)
- Any modern terminal with true color support

---

## Testing

All changes have been tested on:
- macOS Sonoma 14.x
- Apple Silicon (M3 Max)
- zsh 5.9
- tmux 3.x
- Ghostty 1.2.3

---

## Future Improvements

Planned enhancements:
- [ ] Add tmux session manager script
- [ ] Create project-specific tmux layouts
- [ ] Add more tmux plugins (conditional)
- [ ] Document VS Code terminal integration
- [ ] Add kitty configuration as alternative
