#!/usr/bin/env bash
#
#
# PERSONAL INITIALIZATION FILE ~/.bashrc for GNU bash version 4 or later
#
# This file is normally read ONLY by interactive, NON-login shells each time
# a new session is started or when a script is invoked using /usr/bin/env bash
#
BASH_DIR=~/.bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#
# Shell Options
# major version number ${BASH_VERSINFO[0]} or simply $BASH_VERSINFO
# minor version number ${BASH_VERSINFO[1]}
#
if [ $BASH_VERSINFO -ge 4 ]; then
    # execute any command that is a directory name
    # as if it were an argument to the cd command
    shopt -s autocd

    # attempt to save multi-line commands in the same history entry,
    # adding semicolons where necessary to preserve syntactic correctness
    # (to save multi-line commands with embedded newlines use `lithist`)
    shopt -s cmdhist

    # lists the status of all jobs before exiting,
    # exit will be deferred until a second exit is attempted
    # without any intervening commands.
    shopt -s checkjobs

    # perform spelling corrections on directory names
    shopt -s dirspell

    # enable recursive globbing with **
    shopt -s globstar
fi

# auto-correct spelling when changing directory
shopt -s cdspell

# include filenames beginning with a dot in the results of path expansion
shopt -s dotglob

# append to, rather than overwrite, the history file when a shell exits
shopt -s histappend

# provide an opportunity to re-edit a failed history substitutions
shopt -s histreedit

# allow modification of history substitutions before being parsed by the shell
#shopt -s histverify

# do not attempt to search PATH for completions when command line is empty
shopt -s no_empty_cmd_completion

# case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# patterns which do match any files expand to a null string
#shopt -s nullglob

## bash history settings
export HISTCONTROL=ignoredups:ignorespace

# exclude the following commands from history
export HISTIGNORE="cd( [~-]|(../?)+):exit:fg:date:history*:ls*:pwd:man*:* --help"

# allow 32^3 entries in the shell history (default is 500)
export HISTFILESIZE=32768
export HISTSIZE=$HISTFILESIZE

# set a timestamp format for history entries
export HISTTIMEFORMAT='%F %T '

## Load shell command completions
if [ -f /usr/local/share/share/bash-completion/bash_completion ]; then
    source /usr/local/share/share/bash-completion/bash_completion
fi

## node and npm command completions
if [ -r /usr/local/lib/node_modules/npm/lib/utils/completion.sh ]; then
    source /usr/local/lib/node_modules/npm/lib/utils/completion.sh
fi

# Informative git prompt for bash and fish
# if [ -r "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
#     GIT_PROMPT_THEME=Default
#     __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
#     source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
# fi

## fuzzy find completion
[ -f $BASH_DIR/fzf.bash ] && source $BASH_DIR/fzf.bash

## Sheldon command-line tool to manage and load shell plugins
# set a shell specific configuration file and data directory for installed plugins
# see https://github.com/rossmacarthur/sheldon/issues/166
export SHELDON_CONFIG_DIR="${XDG_CONFIG_HOME:-$BASH_DIR}/bash-plugins.toml"
export SHELDON_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/sheldon/bash"

## Carapace multi-shell multi-command argument completer
# https://carapace-sh.github.io/carapace-bin/setup.html#bash
if command -v carapace 1>/dev/null 2>&1; then
    export CARAPACE_BRIDGES='zsh,fish,bash'
    source <(carapace _carapace)
fi

# https://sheldon.cli.rs/Getting-started.html#loading-plugins
if command -v sheldon 1>/dev/null 2>&1; then
    eval "$(sheldon source)"
fi

## Zellij terminal multiplexer
# https://zellij.dev/documentation/integration.html
if command -v zellij 1>/dev/null 2>&1; then
    eval "$(zellij setup --generate-auto-start bash)"
fi

## replace default cd command with zoxide
# https://github.com/ajeetdsouza/zoxide
if command -v zoxide 1>/dev/null 2>&1; then
    eval "$(zoxide init bash --cmd cd)"
fi

## mise-en-place dev tools, environment, and tasks manager
# https://mise.jdx.dev/about.html
if command -v mise 1>/dev/null 2>&1; then
    eval "$(mise activate bash)"
fi

## try manager for code experiments
# https://github.com/tobi/try
if command -v try 1>/dev/null 2>&1; then
    export TRY_PATH="$HOME/Code/sketches/"
    mkdir -p $TRY_PATH # ensure tries directory has been created
    eval "$(/usr/local/bin/try init)"
fi
