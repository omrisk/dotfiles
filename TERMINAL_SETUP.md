# Terminal setup

Ghostty + tmux + zsh with Gruvbox Dark theme.

## Components

| Tool | Config | What it does |
|------|--------|-------------|
| **Ghostty** | `~/.config/ghostty/config` | Terminal emulator. Gruvbox Dark theme, MesloLGS NF font. |
| **tmux** | `~/.tmux.conf` | Multiplexer. Prefix is `Ctrl+s`. 50k line scrollback. |
| **zsh** | `~/.zshrc` | Shell. Powerlevel10k prompt, 4 plugins, no framework. |

## Install

```bash
brew install --cask ghostty
brew install --cask font-meslo-lg-nerd-font
cd ~/dev/dotfiles && ./bootstrap.sh
```

Open Ghostty. You should see the Gruvbox Dark theme and a two-line prompt with git info.

## tmux quick reference

### Basics

All tmux commands start with the prefix `Ctrl+s`, then a key:

| Keys | Action |
|------|--------|
| `Ctrl+s -` | Split horizontally |
| `Ctrl+s \` | Split vertically |
| `Ctrl+s c` | New window |
| `Ctrl+s d` | Detach (tmux keeps running) |
| `Ctrl+s r` | Reload config |
| `Ctrl+s j` | Pick a session |
| `Ctrl+s K` | Kill session |

### Navigation

| Keys | Action |
|------|--------|
| `Ctrl+h/j/k/l` | Move between panes |
| `Shift+Arrow` | Resize pane (small) |
| `Ctrl+Arrow` | Resize pane (large) |
| `Ctrl+s <number>` | Switch to window N |

### Copy mode

| Keys | Action |
|------|--------|
| `Ctrl+s [` | Enter copy mode (scrollback) |
| `j/k` | Navigate |
| `Ctrl+u/d` | Page up/down |
| `/` | Search |
| `v` | Start selection |
| `y` | Copy |
| `q` | Exit |

### Sync panes

`Ctrl+s y` — toggles typing to all panes at once.

## Ghostty keybindings

| Keys | Action |
|------|--------|
| `Cmd+N` | New window |
| `Cmd+T` | New tab |
| `Cmd+W` | Close |
| `Cmd++/-` | Font size |
| `Cmd+0` | Reset font size |
| `Cmd+Shift+C` | Reload config |

## Changing the theme

Terminal theme (Ghostty):
```bash
# Edit ~/.config/ghostty/config
theme = Tokyo Night  # or any theme from: ghostty +list-themes
```

Tmux theme: change `@tmux-gruvbox` in `~/.tmux.conf`.

Prompt colors: edit `~/.p10k.zsh` (hex color values for each segment).

## Troubleshooting

**Icons/symbols look broken:** Install the font: `brew install --cask font-meslo-lg-nerd-font`, then restart Ghostty.

**Colors look wrong in tmux:** Check `echo $TERM` shows `tmux-256color` inside tmux, `xterm-256color` outside.

**Claude Code "nested session" error:** Fixed in `.tmux.conf` via `set-option -ga update-environment " -r CLAUDECODE"`. If it persists, run `tmux kill-server` and reopen Ghostty.

**Shell is slow:** Check startup time printed at the top. If over 1s, profile with `zprof`:
```bash
# Add to top of ~/.zshrc temporarily:
zmodload zsh/zprof
# Add to bottom:
zprof
```

**tmux plugins not working:** Install TPM and plugins:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then in tmux: Ctrl+s I (capital I)
```
