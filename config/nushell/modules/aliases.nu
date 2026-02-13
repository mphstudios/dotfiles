# Nushell aliases and custom commands
# Loaded via `source alias.nu` in config.nu

# Make the dirs command and its subcommands available in all shells
# see https://www.nushell.sh/book/directory_stack.html#dirs-module-and-commands
use std/dirs

alias pushd = dirs add
alias popd = dirs drop

# relative navigation shortcuts
alias . = echo $env.PWD

alias aliases = help aliases

# clear screen and scroll buffer
alias cls = clear

# always use interactive mode as a safeguard
alias cp = cp --interactive --progress
alias ln = ln -i
alias mv = mv --interactive --progress
alias rm = rm --interactive --trash

# fix unintuitive unix command names
alias unmount = umount

# because this makes sense
alias plugins = plugin

# use nuopen to access Nushell's built-in open; open calls macOS open
def nuopen [arg, --raw (-r)] { if $raw { open -r $arg } else { open $arg } }
alias open = ^open

# alias the built-in ls command to ls-builtin
alias ls-builtin = ls

# List the filenames, sizes, and modification times of items in a directory.
# def ls [
#   --all (-a),         # Show hidden files
#   --long (-l),        # Get all available columns for each entry (slower; columns are platform-dependent)
#   --short-names (-s), # Only print the file names, and not the path
#   --full-paths (-f),  # display paths as absolute paths
#   --du (-d),          # Display the apparent directory size ("disk usage") in place of the directory metadata size
#   --directory (-D),   # List the specified directory itself instead of its contents
#   --mime-type (-m),   # Show mime-type in type column instead of 'file' (based on filenames only; files' contents are not examined)
#   --threads (-t),     # Use multiple threads to list contents. Output will be non-deterministic.
#   ...pattern: glob,   # The glob pattern to use.
# ]: [ nothing -> table ] {
#   let pattern = if ($pattern | is-empty) { [ '.' ] } else { $pattern }
#   (ls-builtin
#     --all=$all
#     --long=$long
#     --short-names=$short_names
#     --full-paths=$full_paths
#     --du=$du
#     --directory=$directory
#     --mime-type=$mime_type
#     --threads=$threads
#     ...$pattern
#   ) | sort-by type name -i
# }

def lsa [] { ls --all }

def lsg [] { ls | sort-by type name --ignore-case | grid --color --icons }

# display long list of entries
def ll [] { ls --long --du }

# include dot file entries
def lla [] { ls --all --long --du }

# list only directory entries
def lsd [] { ls | where type == dir }
def lld [] { ls --long --du | where type == dir }

# list only file entries
def lsf [] { ls | where type == file }
def llf [] { ls --long --du | where type == file }

# list entries by creation date
def llc [] { ls --long | sort-by created }

# list entries by last modified date
def llm [] { ls --long | sort-by modified }

# list entries by size, descending
def lls [] { ls --long --du | sort-by size --reverse }

# OpenSSL checksums
def digest [] { /usr/bin/openssl dgst }

# Display the fingerprint and randomart image generated for a ssh key
def fingerprint [publicKeyFile] { ssh-keygen -lv -E md5 -f $publicKeyFile }

# search for processes by name
def psf [pattern] { ps | where name =~ $pattern }

# output random hexidecimal gradoo
def gradoo [] { ^cat /dev/urandom | hexdump -C | grep "ca fe" }
