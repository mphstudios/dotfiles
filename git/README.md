# git

Git configuration at `~/.config/git/` (XDG).

## Files

- `config` — shared git configuration
- `attributes` — global gitattributes
- `ignore` — global gitignore

## Local overrides

The config includes a local file for machine-specific settings:

```gitconfig
[include]
  path = .github
```

Create `~/.config/git/.github` (not tracked) for identity and credentials:

```gitconfig
[user]
    name = Your Name
    email = you@example.com
```
