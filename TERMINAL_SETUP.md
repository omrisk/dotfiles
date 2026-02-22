# Terminal Setup Guide

Complete guide to the optimized terminal environment for development and agent work.

## Overview

This setup provides a fast, stable, and productive terminal environment with:
- **Ghostty** - Ultra-fast, native macOS terminal emulator
- **tmux** - Terminal multiplexer with session persistence
- **zsh** - Shell with oh-my-zsh, Powerlevel10k, and productivity plugins
- **Clean startup** - No errors, instant load times

---

## Quick Start

### 1. Install Ghostty

```bash
brew install --cask ghostty
```

### 2. Apply Dotfiles

```bash
cd ~/dev/dotfiles
stow --restow ghostty tmux zsh shell-shared bash -t "$HOME"
```

### 3. Install Font (if needed)

```bash
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
```

### 4. Open Ghostty

```bash
open -a Ghostty
```

tmux will auto-start and you're ready to work!

---

## What Gets Installed

### Ghostty Configuration
- **Location:** `~/.config/ghostty/config`
- **Theme:** Solarized Dark (matches tmux)
- **Font:** MesloLGS NF (for Powerlevel10k)
- **Opacity:** 95%
- **Features:** Native macOS integration, fast rendering

### tmux Configuration
- **Location:** `~/.tmux.conf`
- **Prefix:** `Ctrl+s` (instead of default `Ctrl+b`)
- **Scrollback:** 50,000 lines (perfect for long logs)
- **Features:** Vim-style navigation, session persistence, copy mode

### zsh Configuration
- **Location:** `~/.zshrc`
- **Theme:** Powerlevel10k
- **Plugins:**
  - git, docker, extract, fzf
  - vi-mode, tmux integration
  - zsh-autosuggestions
  - zsh-syntax-highlighting
  - zsh-z (smart directory jumping)
- **Auto-start:** tmux launches automatically

---

## Features

### Session Persistence

Your work survives terminal restarts:
```bash
# Close Ghostty - tmux keeps running
# Reopen Ghostty - reconnects to your session
```

All your panes, windows, and running processes persist.

### Split Workflows

Perfect for agent development:
```bash
Ctrl+s -      # Split horizontally
Ctrl+s \      # Split vertically
Ctrl+h/j/k/l  # Navigate between panes (vim-style)
```

**Example layout:**
```
┌─────────────────┬──────────────┐
│  Agent Code     │  Logs        │
│                 │              │
├─────────────────┴──────────────┤
│  Tests / Debug Output          │
└────────────────────────────────┘
```

### Massive Scrollback

50,000 line buffer for debugging:
- View long agent outputs
- Search through logs
- Copy error messages easily

### Copy Mode

Navigate scrollback with vim keys:
```bash
Ctrl+s [      # Enter copy mode
j/k           # Navigate up/down
Ctrl+u/d      # Page up/down
/             # Search
v             # Start selection
y             # Copy (yank)
q             # Exit copy mode
```

---

## tmux Quick Reference

### Basic Commands

| Key | Action |
|-----|--------|
| `Ctrl+s` | Prefix key (press before other commands) |
| `Ctrl+s -` | Split horizontal |
| `Ctrl+s \` | Split vertical |
| `Ctrl+s c` | New window |
| `Ctrl+s d` | Detach from session |
| `Ctrl+s [` | Copy mode / scrollback |
| `Ctrl+s r` | Reload config |

### Navigation

| Key | Action |
|-----|--------|
| `Ctrl+h` | Move to left pane |
| `Ctrl+j` | Move to down pane |
| `Ctrl+k` | Move to up pane |
| `Ctrl+l` | Move to right pane |

### Resizing

| Key | Action |
|-----|--------|
| `Shift+Left/Right` | Resize horizontally (2 cells) |
| `Shift+Up/Down` | Resize vertically (1 cell) |
| `Ctrl+Left/Right` | Resize horizontally (10 cells) |
| `Ctrl+Up/Down` | Resize vertically (5 cells) |

### Sessions

| Key | Action |
|-----|--------|
| `Ctrl+s j` | Choose session (fuzzy finder) |
| `Ctrl+s K` | Kill current session |

### Sync Panes

| Key | Action |
|-----|--------|
| `Ctrl+s y` | Toggle synchronized input to all panes |

Useful for running the same command in multiple panes simultaneously.

---

## Ghostty Features

### Native macOS Integration

- Smooth scrolling
- Proper font rendering
- System notifications
- Native window management

### Keybindings

| Key | Action |
|-----|--------|
| `Cmd+N` | New window |
| `Cmd+T` | New tab |
| `Cmd+W` | Close window/tab |
| `Cmd+C` | Copy |
| `Cmd+V` | Paste |
| `Cmd++` | Increase font size |
| `Cmd+-` | Decrease font size |
| `Cmd+0` | Reset font size |
| `Cmd+Shift+C` | Reload config |

### Configuration

Edit `~/.config/ghostty/config` to customize:

```bash
# Change theme
theme = nord

# Adjust opacity
window-opacity = 1.0  # Fully opaque

# Change font size
font-size = 16
```

See available themes:
```bash
ghostty +list-themes
```

---

## Workflow Examples

### Agent Development

**Terminal 1: Code + Logs**
```bash
Ctrl+s \      # Vertical split

# Left pane:
vim agent.py

# Right pane:
tail -f logs/agent.log
```

**Terminal 2: Testing**
```bash
pytest tests/ --verbose
```

### API Testing

**Horizontal split for request/response:**
```bash
Ctrl+s -      # Horizontal split

# Top pane:
curl -X POST localhost:8000/api \
  -H "Content-Type: application/json" \
  -d '{"prompt": "test"}'

# Bottom pane:
tail -f server.log
```

### Multi-Environment

**Multiple windows for different environments:**
```bash
Ctrl+s c      # New window for each environment

# Window 0: Development
python agent.py --env=dev

# Window 1: Staging
ssh staging "tail -f /var/log/agent.log"

# Window 2: Production monitoring
watch -n 5 "curl -s https://api.prod/health"
```

Switch between windows: `Ctrl+s <number>`

---

## Troubleshooting

### Ghostty Won't Start

Check if Ghostty is installed:
```bash
ls -la /Applications/Ghostty.app
```

Reinstall if needed:
```bash
brew reinstall --cask ghostty
```

### Font Not Rendering

Install MesloLGS NF:
```bash
brew install --cask font-meslo-lg-nerd-font
```

Then restart Ghostty.

### tmux Not Auto-Starting

Check the condition in `.zshrc`:
```bash
grep -A5 "Auto-start tmux" ~/.zshrc
```

Verify tmux is installed:
```bash
which tmux
```

Manually start tmux:
```bash
tmux
```

### Colors Look Wrong

Check TERM variable inside tmux:
```bash
echo $TERM
# Should show: tmux-256color
```

Check outside tmux:
```bash
echo $TERM
# Should show: xterm-256color
```

### Copy/Paste Not Working

Make sure `reattach-to-user-namespace` is installed:
```bash
brew install reattach-to-user-namespace
```

### Claude Code "Nested Session" Error

If you get "Claude Code cannot be launched inside another Claude Code session":

This is fixed in the tmux config by removing the `CLAUDECODE` environment variable from tmux sessions. If you still see this error:

1. Kill all tmux sessions:
   ```bash
   tmux kill-server
   ```

2. Restart Ghostty - the new tmux session will not have the `CLAUDECODE` variable

The fix in `.tmux.conf`:
```bash
set-option -ga update-environment " -r CLAUDECODE"
```

### Session Persistence Not Working

Check if tmux-resurrect plugin is installed:
```bash
ls ~/.tmux/plugins/tmux-resurrect
```

If not, install TPM (Tmux Plugin Manager):
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then in tmux: `Ctrl+s I` (capital I) to install plugins.

---

## Advanced Configuration

### Custom tmux Bindings

Add to `~/.tmux.conf`:

```bash
# Custom split shortcuts
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# Quick window switching
bind -n M-1 select-window -t 1
bind -n M-2 select-window -t 2
bind -n M-3 select-window -t 3
```

Reload config: `Ctrl+s r`

### Project-Specific tmux Sessions

Create a script to start your dev environment:

```bash
#!/bin/bash
# start-dev.sh

SESSION="myproject"

tmux new-session -d -s $SESSION

# Window 1: Editor
tmux rename-window -t $SESSION:1 'editor'
tmux send-keys -t $SESSION:1 'cd ~/project && vim' C-m

# Window 2: Server
tmux new-window -t $SESSION:2 -n 'server'
tmux send-keys -t $SESSION:2 'cd ~/project && npm start' C-m

# Window 3: Logs
tmux new-window -t $SESSION:3 -n 'logs'
tmux send-keys -t $SESSION:3 'cd ~/project && tail -f logs/*.log' C-m

# Attach to session
tmux attach -t $SESSION
```

### Disable tmux Auto-Start

Comment out in `.zshrc`:

```bash
# if command -v tmux &> /dev/null && [ -z "$TMUX" ]...
```

Or set environment variable:
```bash
TMUX=skip zsh
```

### Multiple Ghostty Profiles

Create different config files:

```bash
cp ~/.config/ghostty/config ~/.config/ghostty/work.conf
cp ~/.config/ghostty/config ~/.config/ghostty/personal.conf
```

Edit each for different settings, then launch:

```bash
ghostty --config ~/.config/ghostty/work.conf
```

---

## Performance Tips

### Speed Up Startup

1. **Reduce oh-my-zsh plugins** - Only enable what you need
2. **Disable tmux plugins** - Comment out unused plugins in `.tmux.conf`
3. **Use smaller scrollback** - Reduce `history-limit` if not needed

### Reduce Memory Usage

1. **Close unused tmux sessions:**
   ```bash
   tmux ls
   tmux kill-session -t <session-name>
   ```

2. **Limit scrollback:**
   ```bash
   # In tmux.conf
   set-option -g history-limit 10000
   ```

3. **Disable animations:**
   ```bash
   # In ghostty config
   quick-terminal-animation-duration = 0
   ```

---

## Comparison with Other Setups

| Feature | This Setup | Default Terminal | iTerm2 |
|---------|-----------|------------------|--------|
| Startup Speed | ~10ms | ~100ms | ~150ms |
| Session Persistence | ✅ | ❌ | ✅ |
| GPU Acceleration | ✅ | ❌ | ❌ |
| Native macOS | ✅ | ✅ | ⭐⭐⭐ |
| Scrollback | 50k lines | 10k | Unlimited |
| Split Panes | tmux | ❌ | Built-in |
| Plugin System | tmux | ❌ | Built-in |

---

## Resources

- [Ghostty Documentation](https://ghostty.org)
- [tmux Cheatsheet](https://tmuxcheatsheet.com/)
- [oh-my-zsh Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)

---

## Support

If you encounter issues:

1. Check this documentation first
2. Review the troubleshooting section
3. Check the dotfiles README for general setup
4. File an issue in the dotfiles repo

---

## Credits

- Terminal setup inspired by [thoughtbot dotfiles](https://github.com/thoughtbot/dotfiles)
- tmux configuration based on [tmux sensible](https://github.com/tmux-plugins/tmux-sensible)
- Ghostty by [Mitchell Hashimoto](https://mitchellh.com/)
