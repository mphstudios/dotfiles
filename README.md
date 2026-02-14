# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/) and organized following the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/).

## Requirements

- [GNU Stow](https://www.gnu.org/software/stow/) (`brew install stow`)

## Installation

```sh
git clone <repo-url> ~/Code/dotfiles
cd ~/Code/dotfiles

# Install all packages
sh setup.sh

# Or install selectively
stow bash git
```

Stow reads `.stowrc` for default options including `--target=$HOME`.

## Packages

Each top-level directory is a stow package. Contents mirror the target directory structure relative to `$HOME`.

### Shells

| Package | Description | Config path |
|---------|-------------|-------------|
| `bash` | Bash shell | `~/.config/bash/` |
| `nushell` | Nushell | `~/.config/nushell/` |
| `zshell` | Zsh shell | `~/.config/zsh/` |

### Development

| Package | Description | Config path |
|---------|-------------|-------------|
| `git` | Git | `~/.config/git/` |
| `ruby` | IRB, Pry, RuboCop, Gem | `~/.config/{irb,pry,rubocop,gem}/` |
| `python` | Python startup | `~/.config/python/` |
| `node` | npm | `~/.config/node/` |
| `postgres` | psql | `~/.config/postgres/` |

### Tools

| Package | Description | Config path |
|---------|-------------|-------------|
| `ghostty` | Ghostty terminal | `~/.config/ghostty/` |
| `starship` | Starship prompt | `~/.config/starship.toml` |
| `mise` | mise version manager | `~/.config/mise/` |
| `eza` | eza ls replacement | `~/.config/eza/` |
| `yazi` | Yazi file manager | `~/.config/yazi/` |
| `home` | Misc dotfiles in `$HOME` | `~/.*` |

## XDG Base Directories

Most packages store config under `~/.config/` (`XDG_CONFIG_HOME`). Tools without native XDG support use environment variables set in `.profile`:

| Variable | Tool |
|----------|------|
| `PYTHONSTARTUP` | Python startup file |
| `PSQLRC` | PostgreSQL psqlrc |

## Local overrides

Git identity and machine-specific settings go in `~/.config/git/config.local` (not tracked). The git config includes this via `[include] path = config.local`.
