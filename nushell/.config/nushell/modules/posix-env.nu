# Import environment variables from a POSIX shell profile
#
# Sources ~/.profile via bash and loads the resulting environment into nushell,
# eliminating the need to duplicate env var definitions across shells.
#
# Usage:
#   use modules/posix-env.nu
#   posix-env load           # load from ~/.profile
#   posix-env load ~/.env    # load from a specific file
#
# See also: https://github.com/tesujimath/bash-env-nushell

# Bash-internal variables that should not be imported into nushell:
#   SHELL    - would be /bin/bash (the subprocess), not the user's login shell
#   SHLVL    - bash's shell nesting depth, nushell tracks its own
#   OLDPWD   - bash's previous directory, nushell manages its own
#   PWD      - bash's working directory, nushell manages its own
#   _        - bash's last command argument, transient and meaningless outside bash
#   TERM     - set by the terminal emulator, not by .profile
const SKIP_VARS = ["SHELL", "SHLVL", "PWD", "OLDPWD", "_", "TERM"]

# Load environment variables from a POSIX shell file via bash
export def load [file: path = "~/.profile"] {
    let posix_env = (bash -c $". ($file) && env -0"
        | split row (char null_byte)
        | where { |line| $line != "" }
        | each { |line|
            let parts = ($line | split row "=" --number 2)
            { name: ($parts | first), value: ($parts | last) }
        }
        | where { |r| $r.name not-in $SKIP_VARS }
        | transpose --header-row --as-record
    )

    $posix_env | load-env
    $env.PATH = ($posix_env | get PATH | split row ":")
}
