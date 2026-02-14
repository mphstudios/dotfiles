# Nushell environment configuration script
#
# Installed by:
# version = "0.110.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
$env.LC_ALL = "en_US.UTF-8"
$env.LANG = "en_US.UTF-8"

# Directories to search for scripts when calling source or use
# the default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.default-config-dir | path join "modules") # add <nushell-config-dir>/modules
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Nota bene: Nushell does NOT read /etc/paths,
# explicitly set the full base PATH to use Nushell as a login shell
$env.PATH = [
  /usr/local/bin
  /usr/local/sbin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
]

$env.CARAPACE_BRIDGES = 'zsh,fish,bash'

$env.EDITOR = "subl"
$env.VISUAL = (if ("/usr/local/bin/subl" | path exists) {
    "/usr/local/bin/subl --new-window"
} else {
    $env.EDITOR
})

# Homebrew
$env.HOMEBREW_CASK_OPTS = "--appdir=/Applications"
$env.HOMEBREW_NO_ANALYTICS = "true"
$env.HOMEBREW_NO_AUTO_UPDATE = "true"
$env.HOMEBREW_NO_EMOJI = "true"
$env.HOMEBREW_NO_ENV_HINTS = "true"
$env.HOMEBREW_NO_GITHUB_API = "true"
$env.HOMEBREW_NO_INSECURE_REDIRECT = "true"

# PostgreSQL
$env.PGDATA = "/usr/local/var/postgres"
