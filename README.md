# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/) and organized following the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/).

## Requirements

- [GNU Stow](https://www.gnu.org/software/stow/) (`brew install stow`)

## Installation

```sh
git clone <repo-url> ~/Code/dotfiles
cd ~/Code/dotfiles

# Install all packages
./setup

# Or install selectively
stow bash git
```

Stow reads `.stowrc` for default options including `--target=$HOME`.

## Packages

Each top-level directory is a stow _package_. Contents mirror the _target_ directory structure relative to `$HOME`.

### Shells

| Package | Description | Config path |
|---------|-------------|-------------|
| `bash` | Bash shell | `~/.config/bash/` |
| `nushell` | Nushell | `~/.config/nushell/` |
| `zshell` | Z Shell | `~/.config/zsh/` |

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

## Workflows

All `stow` commands are run from the dotfiles directory. Use `--simulate` (dry-run) to preview what stow will do before making changes. Run `./setup --help` to see available commands.

### Install a package

```sh
cd ~/Code/dotfiles
stow --simulate git    # preview
stow git               # apply
```

Stow creates symlinks from `$HOME` into the dotfile repository _package_ directory. For example, `stow git` symlinks `~/.config/git/` to `Code/dotfiles/git/.config/git/`.

### Add a new package from existing config

```sh
./setup add .config superfile
./setup add .config/superfile   # equivalent
```

Or scan `~/.config` for unmanaged directories:

```sh
./setup add .config
```

For dotfiles in `$HOME` (e.g. `~/.foo`):

```sh
./setup add foo
```

### Adopt existing files on a new machine

When setting up a machine that already has config files where stow wants to create symlinks, `--adopt` moves those existing _target_ files into the _package_ and replaces them with symlinks. Review with `git diff` afterward — adopted files overwrite the repo versions.

```sh
cd ~/Code/dotfiles
stow --adopt --simulate git   # preview
stow --adopt git              # apply
```

### Remove a package

```sh
cd ~/Code/dotfiles
stow -D git
```

## XDG Base Directories

Most packages store config under `~/.config/` (`XDG_CONFIG_HOME`). Tools without native XDG support are redirected via environment variables in `.profile` (e.g. `PYTHONSTARTUP`, `PSQLRC`, `INPUTRC`, `GNUPGHOME`, `CARGO_HOME`, `RUSTUP_HOME`). See `.profile` for the full list.

## Local overrides

Git identity and machine-specific settings go in `~/.config/git/config.local` (not tracked). The git config includes this via `[include] path = config.local`.

## Design decisions

### Why GNU Stow?

Stow was chosen for the simplicity of its mental model where the dotfiles repository mirrors the source `$HOME` directory with individual _packages_ at the repository root. Of special note, using `stow` in this way, the dotfiles repository does *not* take over `~/.config`, which allows `~/.config` to contain both managed and unmanaged dotfiles.

- **No abstraction layer.** Config files are stored as-is in the repository — what you see is what gets linked. There is no templating language, no compilation step, no intermediate format to learn or debug.
- **The repository _is_ the documentation.** The directory structure mirrors `$HOME`, no mapping file or manifest is needed. Each dotfiles _package_ mirrors its structure in `$HOME` and each can be symlinked independently, `git/.config/git/config` becomes `~/.config/git/config`. 
- **Single responsibility.** Stow only manages symlinks. Version control is `git`, files can be edited using any editor, and the shell setup is the current shell. Each tool does one thing.
- **No other dependencies** beyond stow itself (`brew install stow` or `apt install stow`).

The tradeoff is that Stow does not provide templating for per-machine differences. This is handled instead by convention: tools that need machine-specific config use `include` directives pointing to untracked local files (e.g. `git/config.local`).

### Why XDG Base Directories?

Following the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/) keeps `$HOME` clean by grouping configuration files under `~/.config/`, which aligns naturally with stow's package-per-directory model. Tools without native XDG support are configured to use the XDG base directories via environment variables in `.profile`.

macOS does not set XDG environment variables by default. These are set on login by a user-specific Launch Agent (`~/Library/LaunchAgents/org.freedesktop.xdg-basedir.plist`):

```sh
XDG_CACHE_HOME = "$HOME/Library/Caches"
XDG_CONFIG_HOME = "$HOME/.config"
XDG_DATA_DIRS = "/usr/local/share/:/usr/share/"
XDG_DATA_HOME = "$HOME/.local/share"
XDG_STATE_HOME = "$HOME/.local/state"
```
