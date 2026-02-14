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


# -----------------------------------------------
# ---------->>> zsh-autosuggestions <<<----------
# -----------------------------------------------

# <CTRL-SPACE> to accept the current suggestion
bindkey '^ ' autosuggest-accept

# <CTRL-BACKSPACE> to clear the current suggestion
bindkey '^H' autosuggest-clear
