#!/usr/bin/env zsh
#
# Zsh interactive shell configuration
#
# This file is normally read by login shells each time a new session is started,
# configurtion file load order:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login]
#

# Load shell agnostic user configurtion files
[ -f ~/.profile ] && source ~/.profile
[ -f ~/.private ] && source ~/.private
[ -f ~/.aliases ] && source ~/.aliases

export -U PATH