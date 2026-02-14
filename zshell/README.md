# zshell

Zsh shell configuration. Only `.zshenv` stays in `$HOME` (zsh requires it there). All other files live in `~/.config/zsh/` via `ZDOTDIR`.

## ZDOTDIR

Set in `.zshenv` to redirect zsh to XDG-compliant config:

```zsh
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
```

## Load order

1. `.zshenv` — every session; sets `ZDOTDIR`, disables global rcs
2. `.zprofile` — login shells; sources `.profile` for shell-agnostic env vars
3. `.zshrc` — interactive shells; plugins, aliases, prompt
4. `.zlogin` — login shells; runs after zsh is fully loaded

## Structure

- `.config/zsh/plugins.toml` — sheldon plugin manifest
- `.config/zsh/fzf.zsh` — fzf integration
- `.config/zsh/bindings.zsh` — key bindings
- `.config/zsh/autosuggestions.zsh` — autosuggestion settings
- `.config/zsh/smartdots.zsh` — `...` expands to `../..`
- `.config/zsh/functions/` — autoloaded zsh functions

## Dependencies

- [sheldon](https://sheldon.cli.rs/) — plugin manager (`brew install sheldon`)
- [starship](https://starship.rs/) — cross-shell prompt (`brew install starship`)
- [fzf](https://github.com/junegunn/fzf) — fuzzy finder (`brew install fzf`)
