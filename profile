#!/usr/bin/env sh
#
# Personal login shell configuraton ~/.profile
#
# A shell agnostic file for login configuration and environment variables.
#

# look for per directory ack! settings
export ACKRC='.ackrc'

# Set architecture flags
export ARCHFLAGS='-arch x86_64'

export C_INCLUDE_PATH=/usr/local/include

# make vim the default editor
export EDITOR='vim'

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

export GNUTERM='x11'

# enable colored output from commands on FreeBSD-based systems
export CLICOLOR=true

# Symlink Homebrew Cask apps to system Applications directory
# https://github.com/phinze/homebrew-cask/blob/master/USAGE.md
export HOMEBREW_CASK_OPTS='--appdir=/Applications'

if ! command -v most &> /dev/null; then
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

export NODE_PATH=/usr/local/lib/node_modules

# Set the PostgreSQL database directory
export PGDATA=/usr/local/var/postgres

# Python commands executed before the first prompt in interactive mode
export PYTHONSTARTUP=~/.pythonrc.py

#
# Path configuration
# macOS default path is defined in /private/etc/paths
#

# Use user-installed binaries before system install versions.
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# Ensure dotfiles bin directory is loaded first
PATH=$HOME/.bin:$PATH

# Use local node modules
# when invoked from the root directory of a project.
PATH=./node_modules/.bin:$PATH

# Use local gem executables and bundler binstubs
# when invoked from the root directory of a project.
PATH=./bin:./.bundle/bin:$PATH

export PATH

# Since CDPATH is considered first it should begin with the current directory
# so that we can easily change to a subdirectory that also matches one of the
# subsequently listed frequented directories.
CDPATH='.:~:~/Code:~/Documents:~/Dropbox:~/Library:~/Sites:~/Workspaces'
