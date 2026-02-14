#!/usr/bin/env zsh
#
# Zsh shell environment configuration
#
# This file is automatically loaded for every new session,
# configurtion file load order:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login]
#

# Disable Loading Global Profiles
# macOS (>= 10.11) loads /etc/zprofile after user ~/.zshenv is loaded
# /etc/zprofile calls /usr/libexec/path_helper, which adds system directories
# to $PATH, reorders it, and then removes duplicates.
setopt no_global_rcs

# XDG Base Directories set by LaunchAgents/org.freedesktop.xdg-basedir.plist
export PATH="$XDG_BIN_HOME:$PATH"

# Define paths for common programs not using XDG
# export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
# export NODE_REPL_HISTORY="$XDG_STATE_HOME/node/repl_history";
# export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
# export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"
# export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
