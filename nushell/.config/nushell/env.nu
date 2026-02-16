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
# Environment variables shared with POSIX shells are kept in sync with ~/.profile
# To source ~/.profile via bash instead of duplicating, see modules/posix-env.nu
#
# XDG Base Directories
# Nota bene: LaunchAgent (org.freedesktop.xdg-basedir.plist) sets these for
# processes spawned by launchd. Defaults are repeated here so that nushell
# sessions that do not inherit LaunchAgent variables also have correct values.
$env.XDG_CACHE_HOME = ($env.XDG_CACHE_HOME? | default ($env.HOME | path join "Library/Caches"))
$env.XDG_CONFIG_HOME = ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config"))
$env.XDG_DATA_HOME = ($env.XDG_DATA_HOME? | default ($env.HOME | path join ".local/share"))
$env.XDG_STATE_HOME = ($env.XDG_STATE_HOME? | default ($env.HOME | path join ".local/state"))

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

# Homebrew on Apple Silicon uses /opt/homebrew instead of /usr/local
if ("/opt/homebrew/bin" | path exists) {
    $env.PATH = ([/opt/homebrew/bin /opt/homebrew/sbin] | append $env.PATH)
}

$env.CARAPACE_BRIDGES = 'zsh,fish,bash'
$env.CLICOLOR = "true"

$env.EDITOR = "subl"
$env.VISUAL = (if ("/usr/local/bin/subl" | path exists) {
    "/usr/local/bin/subl --new-window"
} else {
    $env.EDITOR
})

# Use XDG Base Directory for configuration files
$env.CARGO_HOME = ($env.XDG_DATA_HOME? | default ($env.HOME | path join ".local/share") | path join "cargo")
$env.CURL_HOME = ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config") | path join "curl")
$env.DOCKER_CONFIG = ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config") | path join "docker")
$env.EZA_CONFIG_DIR = ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config") | path join "eza")
$env.GNUPGHOME = ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config") | path join "gnupg")
$env.INPUTRC = ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config") | path join "readline/inputrc")
$env.LESSHISTFILE = ($env.XDG_STATE_HOME? | default ($env.HOME | path join ".local/state") | path join "less/history")
$env.NODE_REPL_HISTORY = ($env.XDG_STATE_HOME? | default ($env.HOME | path join ".local/state") | path join "node/repl_history")
$env.NPM_CONFIG_CACHE = ($env.XDG_CACHE_HOME? | default ($env.HOME | path join ".cache") | path join "npm")
$env.NPM_CONFIG_USERCONFIG = ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config") | path join "npm/npmrc")
$env.PYTHON_HISTORY = ($env.XDG_STATE_HOME? | default ($env.HOME | path join ".local/state") | path join "python/history")
$env.PYTHONSTARTUP = ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config") | path join "python/pythonrc.py")
$env.RUSTUP_HOME = ($env.XDG_DATA_HOME? | default ($env.HOME | path join ".local/share") | path join "rustup")
$env.WGETRC = ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config") | path join "wget/wgetrc")

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
$env.PSQLRC = ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config") | path join "postgres/psqlrc")
