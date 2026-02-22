# Ghostty Configuration

Ultra-fast, native macOS terminal built by Mitchell Hashimoto, optimized for tmux + zsh + agent development.

## Why Ghostty?

- **Blazing fast**: Written in Zig, possibly the fastest terminal available
- **Native macOS**: True native integration, better than any other terminal
- **Modern**: Built from scratch with modern best practices
- **Lightweight**: Minimal resource usage
- **GPU-accelerated**: Smooth rendering at any scale

## Installation

```bash
brew install --cask ghostty
```

## Features

- **Solarized Dark theme**: Matches your tmux color scheme
- **Auto tmux integration**: Uses the same zsh auto-start
- **Native keybindings**: Cmd+C/V/N/W work as expected
- **95% opacity**: Subtle transparency
- **Shell integration**: Native zsh integration for better prompts

## Configuration

Config file: `~/.config/ghostty/config`

### Key Settings

- **Font**: MesloLGS NF (14pt) for Powerlevel10k
- **Theme**: Solarized Dark
- **Opacity**: 95%
- **Scrollback**: 10,000 lines (tmux handles more)
- **Shell**: zsh with integration features

### Keybindings

| Key | Action |
|-----|--------|
| Cmd+N | New window |
| Cmd+T | New tab |
| Cmd+W | Close window/tab |
| Cmd+C | Copy |
| Cmd+V | Paste |
| Cmd++ | Increase font size |
| Cmd+- | Decrease font size |
| Cmd+0 | Reset font size |
| Cmd+Shift+C | Reload config |

## tmux Integration

When you open Ghostty:
1. Zsh starts automatically
2. tmux attaches to `default` session (or creates it)
3. All tmux keybindings work (prefix: `Ctrl+s`)

## Why Ghostty?

### Key Advantages:
- ✅ **Blazing fast**: Native Zig implementation with GPU acceleration
- ✅ **Native macOS integration**: True native app with proper system integration
- ✅ **Shell integration**: Better prompt support and command detection
- ✅ **Modern codebase**: Built with modern best practices for 2024+
- ✅ **Active development**: Created and maintained by Mitchell Hashimoto
- ✅ **Lightweight**: Minimal resource usage with maximum performance

## Installation Steps

### 1. Install Ghostty (Done ✓)

```bash
brew install --cask ghostty
```

### 2. Apply Configuration

```bash
cd ~/dev/dotfiles
stow --restow ghostty -t "$HOME"
```

### 3. Test It

```bash
# Open Ghostty
open -a Ghostty

# Verify tmux auto-starts
echo $TMUX  # Should show a path

# Test splits
Ctrl+s -  # Horizontal split
Ctrl+s \  # Vertical split
```

## Ghostty-Specific Features

### Shell Integration

Ghostty has native shell integration that improves:
- Prompt rendering
- Command detection
- Output marking
- Jump to commands

This is enabled by default in the config with:
```
shell-integration = zsh
shell-integration-features = cursor,sudo,title
```

### Native macOS

Ghostty uses native macOS APIs for:
- Window management
- Rendering
- Input handling
- System integration

This makes it feel more "Mac-like" than other terminals.

## Troubleshooting

### Font not rendering correctly

Install MesloLGS NF:
```bash
brew install --cask font-meslo-lg-nerd-font
```

Then restart Ghostty.

### Colors look wrong

Check theme setting:
```bash
grep theme ~/.config/ghostty/config
# Should show: theme = solarized-dark
```

### tmux not auto-starting

Check the zsh configuration:
```bash
grep "Auto-start tmux" ~/.zshrc
```

### Config not loading

Reload config:
- `Cmd+Shift+C` in Ghostty
- Or restart Ghostty

Check config location:
```bash
ls -la ~/.config/ghostty/config
```

## Performance Tips

Ghostty is already extremely fast, but you can optimize further:

1. **Reduce scrollback**: Lower `scrollback-limit` if you don't need it
2. **Disable animations**: Set `quick-terminal-animation-duration = 0`
3. **Use tmux scrollback**: Let tmux handle history instead of Ghostty

## Customization

### Change Theme

Ghostty supports many built-in themes. To see available themes:
```bash
ghostty +list-themes
```

Popular options:
- `solarized-dark` (default in this config)
- `solarized-light`
- `dracula`
- `nord`
- `gruvbox-dark`
- `tokyo-night`

Change in config:
```
theme = nord
```

### Adjust Opacity

Edit `window-opacity` (0.0 = transparent, 1.0 = opaque):
```
window-opacity = 1.0  # Fully opaque
window-opacity = 0.85 # More transparent
```

### Different Font

```
font-family = "JetBrains Mono"
font-size = 13
```

## Advanced Configuration

### Multiple Profiles

Ghostty doesn't support profiles natively yet, but you can:
1. Create multiple config files
2. Launch with: `ghostty --config=/path/to/config`

### Custom Keybindings

Add more keybindings:
```
keybind = super+1=goto_tab:1
keybind = super+2=goto_tab:2
keybind = super+left=goto_split:left
keybind = super+right=goto_split:right
```

## Documentation

- [Official Ghostty Docs](https://ghostty.org)
- [GitHub](https://github.com/ghostty-org/ghostty)
- Man pages: `man ghostty` or `man 5 ghostty` (config)

## Comparison with Other Terminals

| Feature | Ghostty | iTerm2 | Default Terminal |
|---------|---------|--------|------------------|
| Startup Speed | ~5ms | ~100ms | ~80ms |
| Native macOS | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| GPU Accel | ✅ | ❌ | ❌ |
| Shell Integration | ✅ | ✅ | ❌ |
| Tabs/Splits | ✅ | ✅ | ✅ |
| Maturity | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Config Format | Simple | GUI/plist | plist |
| Resource Usage | Low | Medium | Low |

## Recommendation

**Use Ghostty** as your primary terminal. It's the fastest, most modern option with excellent macOS integration and minimal resource usage. Your tmux + zsh setup works identically across all terminals, so you can always switch back if needed.
