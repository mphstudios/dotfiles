## Z shell

[Zsh shell](https://www.zsh.org/) configuration files.

### Architecture

Shell configuration files are loaded in the following order:

  1. `.zshenv`
  2. `.zprofile` for login shells
  3. `.zshrc` for interactive shells
  4. `.zlogin` for login shells

#### `.zshenv`

The Zsh environment file is automatically loaded for every new session to configure the shell environment.

In these dotfile the `ZDOTDIR` environment variable is exported from the `.zshenv` file.

#### `.zprofile`

The Zsh profile is normally read by login shells each time a new session is started.

*Nota bene* Zsh does not load `.profile` by default, since these dotfiles use `.profile` as a shell-agnostic configuration file it is loaded by the `.zprofile`.

#### `.zshrc`

The Zsh rc file is _normally_ read only by interactive, NON-login shells each time a new session is started or a script is invoked using the `/usr/bin/env zsh` program (such as the [shebang](https://en.wikipedia.org/wiki/Shebang_%28Unix%29)).

#### `.zlogin`

Z shell is completely loaded before reading the Zsh login configuration file. Statements in the login configuration are not able to modify shell behavior. The login configuration can be used to launch external commands after Z shell has completely loaded.

#### `.zlogout`

Called on logout.

### `~/.zsh` directory

The `.zsh` directory contains additional Z shell scripts and configuration files that are sourced by the other Zsh configuration files.

### `ZDOTDIR` Environment Variable

The `ZDOTDIR` environment variable can be define either in `.profile`, `.zshenv`, or `.zprofile` to specify the Zsh configuration directory.

### Functions

The `functions` directory

### Prompt

Currently configured to use the [Starship](https://starship.rs) cross-shell prompt however configurations for previously used [Spaceship](https://spaceship-prompt.sh) Zsh prompt and [Pure](https://github.com/sindresorhus/pure) ZSH prompt are still included in this repository.

### Shell Plugins

Shell plugins are managed using the [sheldon](https://sheldon.cli.rs/Introduction.html) command-line tool, configured
to read shell specific configuration files for Bash and Zsh, `.config/sheldon/bash-plugins.toml` and `.config/sheldon/zsh-plugins.toml` respectively.

