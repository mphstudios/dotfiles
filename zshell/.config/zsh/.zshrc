#!/usr/bin/env zsh
#
# Zsh interactive shell configuration
#
# This file is normally read ONLY by interactive, NON-login shells each time
# a new session is started or when a script is invoked using /usr/bin/env zsh
#
# Load order of configuration files:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login]
#
ZSH_DIR=$ZDOTDIR

# Load shell agnostic user configuration files
[ -f ~/.profile ] && source ~/.profile
[ -f ~/.private ] && source ~/.private
[ -f ~/.aliases ] && source ~/.aliases

# add custom functions to fpath and autoload each
fpath=($ZSH_DIR/functions "${fpath[@]}")
autoload -Uz $ZSH_DIR/functions/*(.:t)

# Z shell move command
autoload -U zmv


# -----------------------------------------------
# --------->>> DIRECTORY NAVIGATION <<<----------
# -----------------------------------------------

DIRSTACKSIZE=7

setopt auto_cd      # if command is unrecognized and is the name of a directory
setopt auto_pushd   # cd pushes old directory onto the directory stack
setopt cdable_vars  # attempt to expand any cd argument that is not a directory
setopt pushd_ignore_dups  # do not push dupelicates onto the directory stack
setopt pushd_minus        # exchange ‘+’ and ‘-’ for the directory stack
setopt pushd_to_home      # pushd with no arguments acts like ‘pushd $HOME’


# -----------------------------------------------
# -------------->>> COMPLETION <<<---------------
# -----------------------------------------------

setopt always_to_end    # move cursor to end of word on full completion
setopt auto_list        # automatically list choices on an ambiguous completion
setopt auto_menu        # show completion menu on successive tab press
setopt complete_aliases # make aliases distinct commands for completion purposes
setopt complete_in_word # completion from both start and end of a word
setopt glob_complete    # generate matches and cycle through like menu_complete
setopt hash_list_all    # avoid false reports of spelling errors
setopt list_ambiguous   # auto-list only when nothing would be inserted
setopt list_types       # show file types in completion list
setopt no_list_beep     # do not beep on an ambiguous completion

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# pasting with tabs does not perform completion
zstyle ':completion:*' insert-tab pending

autoload -Uz compinit
[[ -d ${XDG_CACHE_HOME:-$HOME/.cache}/zsh ]] || mkdir -p ${XDG_CACHE_HOME:-$HOME/.cache}/zsh
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

# -----------------------------------------------
# ------------->>> EXPANSION <<<-----------------
# -----------------------------------------------
unsetopt no_match         # do not print an error when filename has no matches

setopt extended_glob      # treat ‘#~^’ as part of filename generation patterns
setopt glob_dots          # do not require leading ‘.’ for explicit file match
setopt glob_star_short    # pattern ‘**/*’ can be abbreviated as ‘**’, et cetera
setopt no_case_glob       # case-insensitive globbing
setopt numeric_glob_sort


# -----------------------------------------------
# -------------->>> HISTORY <<<------------------
# -----------------------------------------------

# set an exclude pattern to use when history files are written
# matching commands are still added to the interactive history
HISTORY_IGNORE="(cd|cd ..|cls|l[alsh]#( *)#|llg|open .|pwd|exit)"

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h}
HISTSIZE=1000
SAVEHIST=1000

setopt APPEND_HISTORY       # append to the history file rather than replace it
setopt BANG_HIST            # expand '!' character when writing to history
setopt EXTENDED_HISTORY     # <beginning time>:<elapsed seconds>;<command>
setopt HIST_EXPIRE_DUPS_FIRST # expire duplicates first when trimming history
setopt HIST_FCNTL_LOCK      # use system fcntl call to lock history files
setopt HIST_IGNORE_DUPS     # do not record consecutive duplicate entries
setopt HIST_IGNORE_ALL_DUPS # delete older entry if a new entry is a duplicate
setopt HIST_IGNORE_SPACE    # do not add commands that begin with <SPACE>
setopt HIST_NO_FUNCTIONS    # do not record function definitions
setopt HIST_NO_STORE        # do not reocrd the 'history' command
setopt HIST_REDUCE_BLANKS   # remove superfluous blanks before recording entry
setopt HIST_SAVE_NO_DUPS    # do not write duplicate entries to history files
unsetopt HIST_VERIFY        # exec command without reload into the editing buffer
setopt INC_APPEND_HISTORY   # incrementally write to history files


# -----------------------------------------------
# ----------->>> INPUT/OUTPUT <<<----------------
# -----------------------------------------------

setopt aliases      # expand aliases
setopt correct      # auto-correction prompt for mistyped commands
setopt ignore_eof   # do not exit on end-of-file
setopt no_clobber   # do not override files using `>` (override using `>!`)
setopt path_dirs    # search path even on command names containing slashes


# -----------------------------------------------
# ------------>>> JOB CONTROL <<<----------------
# -----------------------------------------------

setopt long_list_jobs # print job notifications in long format by default
setopt no_hup         # do not send HUP signal to jobs when the shell exits
setopt no_bg_nice     # do not nice background tasks


# -----------------------------------------------
# --------------->>> PLUGINS <<<-----------------
# -----------------------------------------------

## Sheldon command-line tool to manage and load shell plugins
# set a shell specific configuration file and data directory for installed plugins
# see https://github.com/rossmacarthur/sheldon/issues/166
export SHELDON_CONFIG_FILE="$ZSH_DIR/plugins.toml"
export SHELDON_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/sheldon/zsh"

# https://sheldon.cli.rs/Getting-started.html#loading-plugins
if (( $+commands[sheldon] )) then
  eval "$(sheldon source)"
fi

# Load configuration for zsh-autosuggestions plugin
[ -f $ZSH_DIR/autosuggestions.zsh ] && source $ZSH_DIR/autosuggestions.zsh


# -----------------------------------------------
# -------->>> ADDITIONAL CONFIG FILES <<<--------
# -----------------------------------------------

[ -f $ZSH_DIR/bindings.zsh ] && source $ZSH_DIR/bindings.zsh

[ -f $ZSH_DIR/smartdots.zsh ] && source $ZSH_DIR/smartdots.zsh

## Atuin improved shell history for zsh, bash, fish and nushell
# https://docs.atuin.sh/cli/guide/installation/
if (( $+commands[atuin] )) then
  eval "$(atuin init zsh)"
fi

## Starship cross-shell prompt
# https://starship.rs/config/
if (( $+commands[starship] )) then
  eval "$(starship init zsh)"
fi

## Carapace multi-shell multi-command argument completer
# https://carapace-sh.github.io/carapace-bin/setup.html#zsh
if (( $+commands[carapace] )) then
  export CARAPACE_BRIDGES='zsh,fish,bash'
  zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
  source <(carapace _carapace)
fi

## mise-en-place dev tools, environment, and tasks manager
# https://mise.jdx.dev/about.html
if (( $+commands[mise] )) then
  eval "$(mise activate zsh)"
fi

## Zellij terminal multiplexer
# https://zellij.dev/documentation/integration.html
if (( $+commands[zellij] )) then
  eval "$(zellij setup --generate-auto-start zsh)"
fi

## replace default cd command with zoxide
# https://github.com/ajeetdsouza/zoxide
if (( $+commands[zoxide] )) then
  eval "$(zoxide init zsh --cmd cd)"
fi
