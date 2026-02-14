#
# fzf https://github.com/junegunn/fzf
#
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Auto-completion
[[ $- == *i* ]] && source '/usr/local/opt/fzf/shell/completion.bash' 2> /dev/null

# Key bindings
source '/usr/local/opt/fzf/shell/key-bindings.bash'

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND="fd . $HOME --type f --hidden --follow --exclude .git"

export FZF_DEFAULT_OPTS='--inline-info --layout=reverse --no-height'

# Load colour scheme
[ -f ~/.fzf-base16-dracula ] && source ~/.fzf-base16-dracula

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# Use ~~ as the trigger sequence, the default is **
export FZF_COMPLETION_TRIGGER='**'

#
# CTRL-R
# fzf search command history and past the selected command onto the command line
#

# display full command in the preview window
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:1:hidden:wrap --bind '?:toggle-preview'"

#
# CTRL-T
# fzf search and paste selected paths onto the command line
#
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || rougify {} || cat {} || tree -C {}) 2> /dev/null | head -200' --preview-window=right:70%:wrap"

#
# ALT-C
# fzf search and cd into the selected directory
#
export FZF_ALT_COMMAND="fd -t d . $HOME"

# use the tree command to show the entries of the directory
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Use fd instead of the default find command for listing path candidates.
# The first argument to the function ($1) is the base path to start traversal.
# See the source code (completion.{bash,zsh}) for details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# fuzzy-find and cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
    -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
