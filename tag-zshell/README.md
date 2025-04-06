## Z Shell

Zsh interactive shell configuration

### Architecture

Shell configuration files are loaded in the following order:

  1. `.zshenv`
  2. `.zprofile` for login shells
  3. `.zshrc` for interactive shells
  4. `.zlogin` for login shells

#### `.zshenv`

The `.zshenv` file is automatically loaded for every new session to configure the shell environment.

#### `.zprofile`

The `.zprofile` file is normally read by login shells each time a new session is started.

#### `.zshrc`

#### `.zlogin`

#### `.zlogout`


### `~/.zsh` directory


### Functions

The `~/.zsh/functions` directory


### Shell Plugins

This configuration uses the [sheldon](https://sheldon.cli.rs/Introduction.html) command-line tool to manage shell plugins,
and sets a shell specific configuration file `.config/sheldon/zsh-plugins.toml`
