# -----------------------------------------------------
# ------------->>> zsh-autosuggestions <<<-------------
# See https://github.com/zsh-users/zsh-autosuggestions
# -----------------------------------------------------

# Add history-substring-search-* to list of widgets that clear suggestions
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-uphistory-substring-search-down)
# Remove *-line-or-history from list of widgets that clear the suggestion
# to avoid conflicts with history-substring-search-* widgets
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")

ZSH_AUTOSUGGEST_STRATEGY=(history)

ZSH_AUTOSUGGEST_USE_ASYNC=true
