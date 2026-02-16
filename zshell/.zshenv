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

# XDG Base Directories
# Nota bene: LaunchAgent (org.freedesktop.xdg-basedir.plist) sets these for
# processes spawned by launchd (GUI applications and login shells).
# Defaults are repeated here so that non-login zsh sessions such as subshells,
# scripts, and shells spawned outside launchd (e.g. SSH, editor terminals),
# also have correct values. Setting a :- fallback ensures the LaunchAgent values
# take precedence when present.
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/Library/Caches}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"

# Starship ignores XDG_CACHE_HOME (starship/starship#6672)
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"

export PATH="$XDG_BIN_HOME:$PATH"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
