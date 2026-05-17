# Changelog

All notable changes to this dotfiles repository.

## 2026-05-17 — Major overhaul

### Changed
- **Replaced Oh-My-Zsh** with 4 direct plugin clones (no framework)
  - zsh-autosuggestions, zsh-syntax-highlighting, zsh-z, powerlevel10k
  - Plugins live in `~/.zsh/plugins/`, managed by bootstrap.sh
- **Switched color theme** from Solarized Dark to Gruvbox Dark (Ghostty, tmux, prompt)
- **Rewrote .zshrc** — 75 lines, down from 142 + 8 sourced files
- **Rewrote bootstrap.sh** — installs Homebrew, tools, plugins, links via Stow, sets shell
- **Updated tmux** — switched theme plugin from tmux-colors-solarized to tmux-gruvbox
- **Cleaned up Ghostty config** — removed unused options, updated theme
- **Optimized .forterrc** — cached pyenv init output, removed `n v16` call (saved ~5.5s)

### Added
- `zsh/.aliases` — curated aliases (41 lines, down from 126)
- `zsh/.p10k.zsh` — Powerlevel10k config with Gruvbox colors, two-line prompt
- `test.sh` — validates plugins, symlinks, tools, and shell startup
- Startup timer — prints load time in ms on every shell start

### Removed
- Oh-My-Zsh dependency (14 plugins → 4)
- Vi-mode keybindings
- Git shell aliases (use full commands)
- jenv (no Java versions installed)
- Redundant `z.sh` sourcing (was loaded twice: Homebrew + OMZ plugin)
- `brew --prefix` subshell on every startup
- `shell-shared` sourcing chain (8 files)

### Archived
- `bash/` — bash config files (`.bashrc`, `.bash_profile`, `.bash_prompt`, etc.)
- `chef/` — Chef/knife helper functions
- `init/` — Solarized terminal/iTerm themes
- `vim/` — legacy vim config
- `utils/` — `.wgetrc`, `.curlrc`, `.functions`, `.ssh_agent`
- `shell-shared/` — old shared shell init
- `zsh.sh`, `brew.sh` — old installer scripts

### Performance
- Shell startup: **6.0s → 0.78s** (7.7x faster)
- Config-only (excluding .forterrc): **0.5s**
- P10k instant prompt shows in ~50ms

---

## 2025-02-22 — Ghostty terminal + startup fixes

### Added
- Ghostty terminal configuration with Solarized Dark theme
- Terminal setup documentation (TERMINAL_SETUP.md)
- TPM existence check in tmux config

### Changed
- Fixed bootstrap.sh Homebrew check logic
- Fixed zsh.sh setting bash instead of zsh as default
- Increased tmux scrollback to 50,000 lines
- Changed tmux terminal type to tmux-256color

### Fixed
- Node version manager verbose output
- jenv plugin double-enable error
- GPG tty "not a terminal" error
- Duplicate pyenv initialization
