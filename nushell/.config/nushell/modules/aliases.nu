# Nushell aliases and custom commands
# Loaded via `source alias.nu` in config.nu

# Make the dirs command and its subcommands available in all shells
# see https://www.nushell.sh/book/directory_stack.html#dirs-module-and-commands
use std/dirs
# Jump to an entry in dirs stack
def --env goto [n: int] { dirs goto $n }
alias pushd = dirs add
alias popd = dirs drop

alias aliases = help aliases

# Copy entries using interactive mode as a safeguard
alias cp = cp --interactive --progress

# Symlink source to target
alias ln = ln -i

# Move entries using interactive mode as a safeguard
alias mv = mv --interactive --progress

# Move entries to Trash
alias rm = rm --interactive --trash

# Parse structured data from `id` command output
def "id parse" [] {
  ^id
  | parse "uid={uid}({user}) gid={gid}({group}) groups={groups}"
  | first
  | update groups {|r|
    $r.groups
    | split row ","
    | each { parse "{gid}({name})" | first }
  }
}

# Use nuopen to access Nushell's built-in open
def nuopen [arg, --raw (-r)] { if $raw { open -r $arg } else { open $arg } }
# macOS open command
alias open = ^open

# List Nushell plugins
alias plugins = plugin

# Unmount a volume
alias unmount = umount

# Alias for the built-in ls command (so that we can define other aliases for ls)
alias ls-builtin = ls

# Redefine ls to default to '.' when no pattern is given, because
# spreading an empty rest list into ls-builtin produces no output.
def ls [
  --all (-a),         # Show hidden files
  --long (-l),        # Get all available columns for each entry (slower; columns are platform-dependent)
  --short-names (-s), # Only print the file names, and not the path
  --full-paths (-f),  # display paths as absolute paths
  --du (-d),          # Display the apparent directory size ("disk usage") in place of the directory metadata size
  --directory (-D),   # List the specified directory itself instead of its contents
  --mime-type (-m),   # Show mime-type in type column instead of 'file' (based on filenames only; files' contents are not examined)
  --threads (-t),     # Use multiple threads to list contents. Output will be non-deterministic.
  ...pattern: glob,   # The glob pattern to use.
]: [ nothing -> table ] {
  let pattern = if ($pattern | is-empty) { ['.'] } else { $pattern }
  (ls-builtin
    --all=$all
    --long=$long
    --short-names=$short_names
    --full-paths=$full_paths
    --du=$du
    --directory=$directory
    --mime-type=$mime_type
    --threads=$threads
    ...$pattern
  ) | sort-by type name -i
}

# display a list of all directory entries
def lsa [...rest] { ls --all ...$rest }

# display directory entries in a grid
def "ls grid" [...rest] { ls ...$rest | sort-by type name --ignore-case | grid --color --icons }

# display directory list, long format
def ll [...rest] { ls --long ...$rest | reject accessed inode num_links readonly }

# display directory list including dot file entries
def lla [...rest] { ls --all --long ...$rest | reject accessed inode num_links readonly }

# find entries with name matching a regular expresion pattern
def "ll name" [pattern] { ls --all --long | reject accessed inode num_links readonly | where name =~ $pattern }

# list only dotfile entries
def "ll." [...rest] { lla ...$rest | where { |it| ($it.name | path basename) | str starts-with "." } }

# list only file entries
def "ls files" [...rest] { lsa ...$rest | where type == file or type == symlink }
def "ll files" [...rest] { lla ...$rest | where type == file or type == symlink }

# list only directory entries
def "ls dirs" [...rest] { ls ...$rest | where type == dir or type == symlink }
def "ll dirs" [...rest] { ll ...$rest | where type == dir or type == symlink }

# list only symlink entries (which requires using the --all flag)
def "ls links" [...rest] { lla ...$rest | where type == symlink | reject created size type }

# list entries by creation date/time
def "ll created" [...rest] { ll ...$rest | sort-by created | reject modified }

# list entries by last modified date/time
def "ll modified" [...rest] { ll ...$rest | sort-by modified | reject created }

# list entries by size, descending
def "ll size" [...rest] { ll ...$rest | sort-by size --reverse | reject created modified }

# OpenSSL checksums
def digest [] { /usr/bin/openssl dgst }

# Display the fingerprint and randomart image generated for a ssh key
def fingerprint [publicKeyFile] { ssh-keygen -lv -E md5 -f $publicKeyFile }

# output random hexidecimal gradoo
def gradoo [] { ^cat /dev/urandom | hexdump -C | grep "ca fe" }
