#!/usr/bin/env sh
#
# Personal login shell configuraton ~/.profile
#
# A shell agnostic file for login configuration and environment variables.
#
export C_INCLUDE_PATH=/usr/local/include

# Set the default editor
export EDITOR='subl'


# set the default visual editor used by other commands
if [ -f /usr/local/bin/subl ]; then
    export VISUAL='/usr/local/bin/subl --new-window'
else
    export VISUAL=$EDITOR
fi

# Locale
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

# enable colored output from commands on FreeBSD-based systems
export CLICOLOR=true

if command -v most &> /dev/null; then
    export MANPAGER='most'
else
    # Use Less Colors for manual pages
    export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
    export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
    export LESS_TERMCAP_me=$'\e[0m'           # end mode
    export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode info box
    export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
    export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
    export LESS_TERMCAP_ue=$'\e[0m'           # end underline

    # Do not clear the screen after quitting manual pages
    export MANPAGER='less -X'
fi

#
# Path configuration
# macOS default path is defined in /private/etc/paths
#

# Base system path
PATH=/usr/bin:/bin:/usr/sbin:/sbin

# Homebrew: Apple Silicon (/opt/homebrew) or Intel (/usr/local)
if [ -d /opt/homebrew/bin ]; then
    PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
elif [ -d /usr/local/bin ]; then
    PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi

# Cargo (Rust) package manager binaries
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
PATH="$CARGO_HOME/bin:$PATH"

# Use local node modules
# when invoked from the root directory of a project.
PATH=./node_modules/.bin:$PATH

# Use local gem executables and bundler binstubs
# when invoked from the root directory of a project.
PATH=./bin:./.bundle/bin:$PATH

export PATH

# Use XDG Base Directory for configuration files
export CURL_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/curl"
export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/docker"
export EZA_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/eza"
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/readline/inputrc"
export LESSHISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/less/history"
export PYTHON_HISTORY="${XDG_STATE_HOME:-$HOME/.local/state}/python/history"
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/python/pythonrc.py"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"

# Starship ignores XDG_CACHE_HOME (starship/starship#6672)
export STARSHIP_CACHE="${XDG_CACHE_HOME:-$HOME/Library/Caches}/starship"

# Symlink Homebrew Cask apps to system Applications directory
# https://github.com/phinze/homebrew-cask/blob/master/USAGE.md
export HOMEBREW_CASK_OPTS='--appdir=/Applications'

export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_NO_EMOJI=true
export HOMEBREW_NO_ENV_HINTS=true
export HOMEBREW_NO_GITHUB_API=true
export HOMEBREW_NO_INSECURE_REDIRECT=true

export NODE_PATH=/usr/local/lib/node_modules
export NODE_REPL_HISTORY="${XDG_STATE_HOME:-$HOME/.local/state}/node/repl_history"

# Use XDG config directory for npm
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/npm"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export NPM_TOKEN # Set this var in ~/.private

# Set the PostgreSQL database directory
export PGDATA=/usr/local/var/postgres
export PSQLRC="${XDG_CONFIG_HOME:-$HOME/.config}/postgres/psqlrc"

# Since CDPATH is considered first it should begin with the current directory
# so that we can easily change to a subdirectory that also matches one of the
# subsequently listed frequented directories.
CDPATH='.:~:~/Code:~/Documents:~/Library:~/Sites:~/Workspaces'
