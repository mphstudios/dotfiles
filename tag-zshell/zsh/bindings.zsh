# -----------------------------------------------
# -------------->>> Vi mode <<<------------------
# -----------------------------------------------

# Vi mode
bindkey -v

## <CTRL-P> and <CTRL-N> search history
#bindkey '^P' up-history
#bindkey '^N' down-history

# <backspace> and <CTRL-H> even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# <CTRL-W> remove word backwards
bindkey '^w' backward-kill-word

# <CTRL-R> search history backward
bindkey '^r' history-incremental-search-backward


# -----------------------------------------------
# ---------->>> zsh-autosuggestions <<<----------
# -----------------------------------------------

# <CTRL-SPACE> to accept the current suggestion
bindkey '^ ' autosuggest-accept

# <CTRL-BACKSPACE> to clear the current suggestion
bindkey '^H' autosuggest-clear


# -----------------------------------------------
# ----->>> zsh-history-substring-search <<<------
# -----------------------------------------------

# bind <UP> and <DOWN> arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind <UP> and <DOWN> arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# bind <CTRL-P> and <CTRL-N> for Emacs mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for Vi mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
