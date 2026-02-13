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

source modules/aliases.nu

mkdir ($nu.data-dir | path join "vendor/autoload")

atuin init nu | save --force ($nu.data-dir | path join "vendor/autoload/atuin.nu")
carapace _carapace nushell | save --force ($nu.data-dir | path join "vendor/autoload/carapace.nu")
mise activate nu | save --force ($nu.data-dir | path join "vendor/autoload/mise.nu")
starship init nu | save --force ($nu.data-dir | path join "vendor/autoload/starship.nu")
zoxide init nushell | save --force ($nu.data-dir | path join vendor/autoload/zoxide.nu)

$env.config = {
  show_banner: false
}

# overlays must be after $env.config to be merged rather than being overwritten
overlay use modules/macOS.nu
overlay use modules/git.nu
overlay use modules/kamal.nu
overlay use modules/keybindings.nu
