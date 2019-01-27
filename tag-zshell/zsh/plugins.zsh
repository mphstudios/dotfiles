# -----------------------------------------------
# --------------->>> ZPLUG <<<-------------------
# -----------------------------------------------
export ZPLUG_HOME=/usr/local/opt/zplug

source $ZPLUG_HOME/init.zsh

# Let zplug manage itself like other packages
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Load completion library for those sweet [tab] squares
zplug "lib/completion", from:oh-my-zsh

# Auto-suggestions
zplug "zsh-users/zsh-autosuggestions", from:github
# Auto-close, delete, and skip over matching delimiters
zplug "hlissner/zsh-autopair", from:github, defer:2
# Syntax highlighting for commands; load last!
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
# Automatically switch Python virtualenvs when changing directory
zplug "MichaelAquilina/zsh-autoswitch-virtualenv", from:github
# Show reminders when using a command for which you already have an alias
zplug "MichaelAquilina/zsh-you-should-use", from:github
# Priorite history entries executed from the current working directory
#zplug "ericfreese/zsh-prioritize-cwd-history", from:github
# Search history for any part of a command and cycle using <UP> and <DOWN>
zplug "zsh-users/zsh-history-substring-search", from:github
# Vi-mode
zplug "oh-my-zsh/vi-mode", from:oh-my-zsh
# Spaceship-prompt
zplug "denysdovhan/spaceship-prompt", as:theme, from:github, use:"spaceship.zsh"
# Terminal Theme
zplug "dracula/zsh", as:theme

# Iinstall missing plugins, prompt user for confirmation
if ! zplug check --verbose; then
  printf "Install zplug plugins? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Source plugins and add commands to $PATH
zplug load
