# bash

Bash shell configuration. Dotfiles remain in `$HOME` (`.bashrc`, `.bash_profile`, `.bash_logout`) as bash requires. Supporting files live in `~/.config/bash/`.

## BASHDOTDIR

Bash has no built-in equivalent of zsh's `ZDOTDIR`. This config defines `BASHDOTDIR` as a custom convention to point to `$XDG_CONFIG_HOME/bash`:

```bash
BASHDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/bash"
```

## Structure

- `.bashrc` — interactive shell setup
- `.bash_profile` — login shell setup, starship prompt init
- `.bash_logout` — logout cleanup
- `.config/bash/plugins.toml` — sheldon plugin manifest
- `.config/bash/fzf.bash` — fzf integration and helpers
- `.config/bash/fzf-base16-dracula` — fzf colour scheme

## Dependencies

- [sheldon](https://sheldon.cli.rs/) — plugin manager (`brew install sheldon`)
- [starship](https://starship.rs/) — cross-shell prompt (`brew install starship`)
- [fzf](https://github.com/junegunn/fzf) — fuzzy finder (`brew install fzf`)
