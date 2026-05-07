# Nushell configuration script  for settings, commands, and startup tasks
#
# Installed by:
# version = "0.110.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings,
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R
#
# Nota bene:
# Nushell does not use XDG_STATE_HOME and history.path config is not yet supported
#
use std/util "path add"

# prepend to base PATH
path add ./node_modules/.bin
path add ./.bundle/bin
path add ./bin
path add ($env.CARGO_HOME? | default ($env.HOME | path join ".cargo") | path join "bin")
path add ($env.HOME | path join ".local/bin")
path add ($env.HOME | path join ".bin")

# Ensure ghostty command is available in PATH
path add ($env.GHOSTTY_BIN_DIR)

# Sourced explicitly rather than autoloaded: vendor/autoload runs after config.nu
# completes, which would place aliases after the overlays. Sourcing here ensures
# aliases are defined first and cannot be silently shadowed by an overlay.
source modules/aliases.nu

let vendor = ($nu.data-dir | path join "vendor/autoload")
mkdir $vendor

## Atuin improved shell history for zsh, bash, fish and nushell
# https://docs.atuin.sh/cli/guide/installation/
if (which atuin | is-not-empty) {
    atuin init nu | save --force ($vendor | path join "atuin.nu")
}
## Carapace multi-shell multi-command argument completer
# https://carapace-sh.github.io/carapace-bin/setup.html
if (which carapace | is-not-empty) {
    carapace _carapace nushell | save --force ($vendor | path join "carapace.nu")
}
## mise-en-place dev tools, environment, and tasks manager
# https://mise.jdx.dev/installing-mise.html#nushell
if (which mise | is-not-empty) {
    mise activate nu | save --force ($vendor | path join "mise.nu")
}
## Starship cross-shell prompt
# https://starship.rs
if (which starship | is-not-empty) {
    starship init nu | save --force ($vendor | path join "starship.nu")
}
# Nushell integration module for try-rs is generate once by manually running
# try-rs --setup-stdout nu-shell | save --force ($nu.data-dir | path join "vendor/autoload/try-rs.nu")
#
# several issues block automated integration (try-rs 1.7.8 / nushell 0.112.2)
#
#   try-rs does not detect the .local/share/nushell/vendor/autoload/try-rs.nu
#   instead the user is prompted to setup shell integration, writing the module
#   to ~/.config/try-rs/ and instructing the user to source this file,
#   and incorrectly assuming that config.nu is at the default location
#   ~/Library/Application Support/nushell/config.nu
#
#   `--setup nu-shell` writes to the try-rs config directory
#   instead of the nushell vendor/autoload directory, and although we could
#   source ($nu.home-dir | path join ".config/try-rs/try-rs.nu")
#   the try-rs command to generated the module must still be run manually.
#
#   `--setup-stdout nu-shell` emits `^try-rs ...$all_args` immediately
#   followed by `return`, which nushell rejects at runtime with the error
#   "can't convert nothing to string".
#   Plausible fix: capture and return the external's output,
#   something like `return (^try-rs ...$all_args)`.
#
if (which try-rs | is-not-empty) {
    # try-rs --setup-stdout nu-shell | save --force ($vendor | path join "try-rs.nu")
    source ($nu.home-dir | path join ".config/try-rs/try-rs.nu")
}
## Television general-purpose fuzzy finder
# https://alexpasmantier.github.io/television/
if (which tv | is-not-empty) {
    tv init nu | save --force ($vendor | path join "tv.nu")
}
## Worktrunk git worktree management for parallel AI agent workflows
# https://worktrunk.dev/worktrunk/#install
if (which wt | is-not-empty) {
    wt config shell init nu | save --force ($vendor | path join "wt.nu")
}
## replace default cd command with zoxide
# https://github.com/ajeetdsouza/zoxide
if (which zoxide | is-not-empty) {
    zoxide init nushell | save --force ($vendor | path join "zoxide.nu")
}

# Disable Nushell prompt indicators, which duplicate the Starship prompt,
# instead use $env.config.cursor_shape to differentiate prompt modes
$env.PROMPT_INDICATOR_VI_NORMAL = ''
$env.PROMPT_INDICATOR_VI_INSERT = ''

$env.config = {
    cursor_shape: {
        # use cursor_shape to differentiate between prompt modes, options:
        # block, line, underscore, blink_block, blink_line, blink_underscore
        vi_insert: blink_line
        vi_normal: blink_block
    }
    edit_mode: 'vi'
    history: {
        path: ($env.XDG_STATE_HOME | path join "nushell")
    }
    show_banner: false
    table: {
        header_on_separator: false
        # alternative null value symbols: '' # nf-cod-blank, '󰟢' # nf-md-null
        missing_value_symbol: '' # nf-oct-x
        trim: {
            methodology: truncating
            truncating_suffix: '…'
        }
    }
}

# overlays must be after $env.config to be merged rather than being overwritten
overlay use modules/macOS.nu
overlay use modules/exif.nu
overlay use modules/git.nu
overlay use modules/pdf.nu
overlay use modules/keybindings.nu
overlay use modules/greeting.nu

# Display a greeting when these terminal emulators start a session
if (($env.TERM_PROGRAM? | default "") in [Apple_Terminal ghostty]) {
    greet --style splash
}
