# dotfiles

My macOS dotfiles. Managed with [GNU Stow](https://www.gnu.org/software/stow/) — each top-level directory maps to symlinks in `~`.

## Quick start

```bash
git clone https://github.com/omrisk/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./bootstrap.sh
```

That's it. The bootstrap script will:

1. Install Homebrew (if missing)
2. Install tools from the Brewfile
3. Clone zsh plugins to `~/.zsh/plugins/`
4. Symlink all config files to `~` via Stow
5. Set Homebrew's zsh as the default shell

To re-run after pulling changes:

```bash
cd ~/dev/dotfiles && ./bootstrap.sh -f
```

## What gets linked

| Directory    | Creates                        | Purpose                       |
|--------------|--------------------------------|-------------------------------|
| `zsh/`       | `~/.zshrc`, `~/.aliases`, `~/.p10k.zsh` | Shell config, aliases, prompt |
| `ghostty/`   | `~/.config/ghostty/config`     | Terminal emulator             |
| `git/`       | `~/.gitconfig`, `~/.gitconfig_common`, `~/.gitignore` | Git configuration |
| `tmux/`      | `~/.tmux.conf`                 | Terminal multiplexer          |
| `github-cli/`| `~/.config/gh/config.yml`      | GitHub CLI                    |

## How Stow works

Stow creates symlinks from `~` pointing back to this repo. When you edit a file here, it's live immediately — no copying or syncing needed.

```bash
# Re-link everything after adding a new file:
cd ~/dev/dotfiles
stow --restow zsh ghostty git tmux github-cli -t "$HOME"
```

## Shell setup

**No plugin manager.** Four plugins are cloned directly to `~/.zsh/plugins/`:

- **zsh-autosuggestions** — suggests commands as you type
- **zsh-syntax-highlighting** — colors valid/invalid commands
- **zsh-z** — `z` to jump to frequently used directories
- **powerlevel10k** — fast prompt with git status

**Startup time:** ~500ms for the dotfiles config. Prints the load time (in ms) each time you open a terminal.

**Theme:** Gruvbox Dark across Ghostty, tmux, and the prompt.

## Git configuration

The [`.gitconfig`](git/.gitconfig) includes separate configs by context:

- `.gitconfig_common` — aliases and shared preferences (in this repo)
- `.gitconfig_personal` — personal name/email (create this yourself)
- `.gitconfig_work` — auto-loaded when working in `~/dev/` directories

Example `~/.gitconfig_personal`:

```
[user]
  name = Your Name
  email = your@email.com
```

## Validation

Run the test script to check that everything is set up correctly:

```bash
./test.sh
```

This verifies plugins are cloned, symlinks exist, required tools are installed, and the shell starts without errors.

## Updating plugins

```bash
for d in ~/.zsh/plugins/*/; do git -C "$d" pull; done
```

## macOS defaults

Optional — sets sensible macOS system preferences:

```bash
./.macos
```

## Archive

The `archive/` directory contains old configs kept for reference (bash, Chef, Solarized themes, vim). These are not linked or loaded.

## Credit

[Mathias Bynens's dotfiles](https://github.com/mathiasbynens/dotfiles)
