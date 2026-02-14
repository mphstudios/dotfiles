#!/usr/bin/env bash
#
# PERSONAL SHELL INITIALIZATION FILE ~/.bash_profile for GNU bash (version 4+)
#
# On Unix machines this file is executed for login shells each time you login.
#
# When bash is invoked as an interactive login shell, or as a non-interactive
# shell with the --login option, it first reads and executes commands from the
# /etc/profile, then looks for one of ~/.bash_profile ~/.bash_login ~/.profile,
# executing the first of these files that exists and is readable.
#
# Non-login interactive bash shells (subshells) will only read ~/.bashrc unless
# the --login option is specified.
#
# macOS Terminal.app executes ~/.bash_profile with each new Terminal window.
#
BASH_DIR=~/.bash

# Load shell agnostic user configuration files
[[ -f ~/.profile ]] && source ~/.profile
[[ -f ~/.private ]] && source ~/.private
[[ -f ~/.aliases ]] && source ~/.aliases

# Load configuration for interactive non-login shells
[[ -f ~/.bashrc ]] && source ~/.bashrc

# Load custom command prompt
[[ -f $BASH_DIR/prompt.bash ]] && source "$BASH_DIR/prompt.bash"

# Readline configuration
export INPUTRC=~/.inputrc

## Complete SSH hostnames based on ~/.ssh/config (wildcards ignored)
if [ -r ~/.ssh/config ]; then
  complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh
fi
