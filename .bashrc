##
# PERSONAL INITIALIZATION FILE ~/.bashrc for GNU bash version 4 or later
#
# This file is normally read ONLY by interactive, NON-login shells each time
# a new session is started or when a script is invoked using /usr/bin/env bash
#
##

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#echo 'Loading shell configuration from ~/.bashrc'

##
# Shell Options
# major version number ${BASH_VERSINFO[0]} or simply $BASH_VERSINFO
# minor version number ${BASH_VERSINFO[1]}
##
if [ $BASH_VERSINFO -ge 4 ]; then

    # execute any command that is a directory names as if it were an argument to the cd command
    shopt -s autocd

    # attempt to save multi-line commands in the same history entry,
    # adding semicolons where necessary to preserve syntactic correctness
    # (to save multi-line commands with embedded newlines use `lithist`)
    shopt -s cmdhist

    # lists the status of any stopped and running jobs before exiting an interactive shell,
    # exit will be deferred until a second exit is attempted without an intervening command.
    shopt -s checkjobs

    # perform spelling corrections on directory names
    shopt -s dirspell

    # enable recursive globbing with **
    #shopt -s globstar
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
shopt -s histverify

# do not attempt to search PATH for completions when command line is empty
shopt -s no_empty_cmd_completion

# case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# patterns which do match any files expand to a null string
#shopt -s nullglob

# cd command aliases for frequented directories
# Since CDPATH is considered first it should begin with the current directory
# so that we can easily change to a subdirectory that also matches one of the
# subsequently listed frequented directories.
CDPATH=".:~:~/Code:~/Documents:~/Library:~/Workspaces"

##
# bash history settings
##
export HISTCONTROL=ignoredups:ignorespace

# Exclude the following commands from history
export HISTIGNORE="cd( [~-]|(../?)+):exit:fg:date:history*:ls*:pwd:man*:* --help"

# Allow 32^3 entries in the shell history (default is 500)
export HISTFILESIZE=32768
export HISTSIZE=$HISTFILESIZE

# Set a timestamp format for history entries
export HISTTIMEFORMAT='%F %T '

if ! command -v most &> /dev/null; then
    export MANPAGER='most'
else
    # Use Less colors for manual pages
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
