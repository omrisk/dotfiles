# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

macOS dotfiles managed with GNU Stow. Each top-level directory is a "stow package" — its contents mirror the home directory structure. Stow creates symlinks from `~` pointing back to these files, so edits here are live immediately.

## Commands

```bash
# Link all configs to ~
stow --restow zsh ghostty git tmux github-cli -t "$HOME"

# Full setup (Homebrew, plugins, stow, shell)
./bootstrap.sh -f

# Validate setup (plugins, symlinks, tools, shell startup)
./test.sh

# Update plugins
for d in ~/.zsh/plugins/*/; do git -C "$d" pull; done

# Pre-commit hooks
pre-commit run -a
```

## Architecture

**Stow packages** (top-level dirs that get symlinked to `~`):

- `zsh/` → `~/.zshrc`, `~/.aliases`, `~/.p10k.zsh`
- `ghostty/` → `~/.config/ghostty/config`
- `git/` → `~/.gitconfig`, `~/.gitconfig_common`, `~/.gitignore`
- `tmux/` → `~/.tmux.conf`
- `github-cli/` → `~/.config/gh/config.yml`

**Not stowed**: `archive/`, `Homebrew/`, root-level files. Adding a new top-level directory does NOT auto-stow it — you must add it to the `stow` command in `bootstrap.sh` line 58.

**Shell loading order**: `.zshrc` sources plugins from `~/.zsh/plugins/` (not in this repo — cloned by bootstrap.sh), then `~/.aliases`, then `~/.forterrc` (work config, not in this repo), then `~/.p10k.zsh`.

**Git config layering**: `.gitconfig` includes `.gitconfig_common` (shared settings, in this repo), `.gitconfig_personal` (user-created, not in repo), and conditionally `.gitconfig_work` for paths under `~/dev/`.

**Theme**: Gruvbox Dark is applied across Ghostty, tmux (`@tmux-gruvbox`), and Powerlevel10k (hex colors in `.p10k.zsh`). Keep all three in sync when changing themes.

## Conventions

- No plugin manager. Plugins are plain git clones sourced directly.
- Keep .zshrc under 100 lines. Split aliases into `.aliases`, prompt config into `.p10k.zsh`.
- Prefer removing complexity over adding it. No abstractions for one-off operations.
- `archive/` holds legacy configs (bash, Chef, vim, Solarized) for reference — never source or load them.
- After any change to stowed files, run `./test.sh` to validate.
- Shell startup time prints on every terminal open. Keep it under 1 second (excluding `.forterrc`).
