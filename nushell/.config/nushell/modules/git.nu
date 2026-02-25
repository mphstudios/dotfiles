# Nushell overlay for git —
# always active; commands fail naturally with a git error when outside a repository.
#
# Relationship to .config/git/config aliases:
# Git config aliases are resolved by git itself and work in any shell or client
# (e.g. `git save "msg"` → `git stash push --message "msg"`). These functions
# are resolved by nushell and allow dropping the `git` prefix entirely when
# inside a repository (e.g. `stash -m "msg"`). Where both layers define the same
# command they do the same thing via different resolution paths. Commands
# present only in git config (assume, presume, skip, noskip, fixup) have no
# nushell equivalent: fixup requires an interactive rebase and cannot be
# straightforwardly ported; the index-flag pairs are niche enough that the
# `git` prefix is acceptable friction.

# Check whether the current directory is inside a git work tree
export def in-git-repo [] {
  try { (^git rev-parse --is-inside-work-tree | complete).exit_code == 0 } catch { false }
}

# --- Inspection ---

# Show the working tree status
export def --wrapped status [...args] {
  ^git status ...$args
}

# Show a graph log of commits
export def --wrapped log [...args] {
  ^git log --graph --decorate --pretty=oneline --abbrev-commit ...$args
}

# Show a simplified graph of all branch tips
export def --wrapped tree [...args] {
  ^git log --all --graph --decorate --oneline --simplify-by-decoration ...$args
}

# Show changes between commits, working tree, etc.
export def --wrapped diff [...args] {
  ^git diff ...$args
}

# Show a word-level diff
export def --wrapped 'diff words' [...args] {
  ^git diff --word-diff=color ...$args
}

# List untracked files not covered by .gitignore
export def untracked [] {
  ^git ls-files . --exclude-standard --others | lines
}

# List files ignored by .gitignore
export def ignored [] {
  ^git ls-files . --ignored --exclude-standard --others | lines
}

# --- Staging ---

# Stage changes for the next commit
export def --wrapped stage [...args] {
  ^git add ...$args
}

# Unstage staged changes; defaults to all staged files when no paths are given
export def --wrapped unstage [...args] {
  let targets = if ($args | is-empty) { ['.'] } else { $args }
  ^git restore --staged ...$targets
}

# --- Stashing ---

# Stash changes in a dirty working directory; -m / --message creates a named stash
export def --wrapped stash [
  --message (-m): string  # Description for the stash entry
  ...args                 # Additional arguments passed to git stash
] {
  if ($message | is-not-empty) {
    ^git stash push --message $message ...$args
  } else {
    ^git stash ...$args
  }
}

# List stashes as a structured table with ref and description columns (alias for stash list)
export def stashes [] { stash list }

# List stashes as a structured table with index, ref, branch, description, and date columns
export def 'stash list' [] {
  ^git stash list --format='%gd%x09%gs%x09%ar'
  | lines
  | each {|line|
      let fields = $line | split row "\t"
      let stash_ref = $fields.0
      let subject = $fields.1
      let date = $fields.2
      let index = $stash_ref | parse --regex 'stash@\{(?P<index>\d+)\}' | first | get index | into int
      let subject_fields = $subject | parse --regex '^(?:WIP )?[Oo]n (?P<branch>[^:]+): (?P<description>.+)$' | first
      { index: $index, ref: $stash_ref, branch: $subject_fields.branch, date: $date, description: $subject_fields.description }
    }
}

# Restore the most recent stash and re-apply its index state
export def --wrapped pop [...args] {
  ^git stash pop --index ...$args
}

# Reverse-apply the most recent stash without dropping it
export def unapply [] {
  ^git stash show -p | ^git apply -R
}

# --- Committing ---

# Record changes to the repository
export def --wrapped commit [...args] {
  ^git commit ...$args
}

# Amend the last commit
export def --wrapped amend [...args] {
  ^git commit --amend ...$args
}

# Undo the last n commits, preserving changes in the working tree
export def uncommit [n: int = 1] {
  if $n < 1 { error make { msg: 'n must be at least 1' } }
  ^git reset --soft $"HEAD~($n)"
}

# Discard working tree changes and restore to the last committed state
export def discard [] {
  ^git reset --hard HEAD
}

# --- Branching ---

# List all branches as a structured table with current, kind, name, hash, date, upstream, ahead, and behind columns
export def 'branch list' [pattern?: string] {
  let args = if $pattern != null { [$pattern] } else { [] }
  ^git branch --all --list --format='%(HEAD)%09%(refname)%09%(refname:short)%09%(objectname:short)%09%(committerdate:relative)%09%(upstream:short)%09%(upstream:track)' ...$args
  | lines
  | each {|line|
      let fields = $line | split row "\t"
      let kind = if ($fields.1 | str starts-with "refs/remotes") { "remote" } else { "local" }
      let tracking_info = $fields.6
      let ahead = if ($tracking_info =~ 'ahead \d') {
          $tracking_info | parse --regex 'ahead (?P<count>\d+)' | first | get count | into int
      } else { 0 }
      let behind = if ($tracking_info =~ 'behind \d') {
          $tracking_info | parse --regex 'behind (?P<count>\d+)' | first | get count | into int
      } else { 0 }
      { current: ($fields.0 == "*"), kind: $kind, name: $fields.2, hash: $fields.3, date: $fields.4, upstream: $fields.5, ahead: $ahead, behind: $behind }
    }
}

# List all branches (alias for branch list)
export def branches [] { branch list }

# Create a new branch
export def --wrapped branch [...args] {
  ^git branch ...$args
}

# Switch branches (legacy; also restores working tree files)
export def --wrapped checkout [...args] {
  ^git checkout ...$args
}

# Switch branches
export def --wrapped switch [...args] {
  ^git switch ...$args
}

# Reapply commits on top of another base tip
export def --wrapped rebase [...args] {
  ^git rebase ...$args
}

# Cherry-pick commits
export def --wrapped pick [...args] {
  ^git cherry-pick ...$args
}

# --- Remotes ---

# List remote connections as a structured table with name, url, and operation columns
export def remotes [] {
  ^git remote --verbose
  | lines
  | each {|line|
      let fields = $line | split row "\t"
      let parsed = $fields.1 | parse "{url} ({operation})" | first
      { name: $fields.0, url: $parsed.url, operation: $parsed.operation }
    }
}

# Fetch changes from a remote without merging
export def --wrapped fetch [...args] {
  ^git fetch ...$args
}

# Fetch and integrate changes from a remote
export def --wrapped pull [...args] {
  ^git pull ...$args
}

# Update a remote with local commits
export def --wrapped push [...args] {
  ^git push ...$args
}

# --- Extensions ---

# Git Large File Storage
export def --wrapped lfs [...args] {
  ^git lfs ...$args
}
