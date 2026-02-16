# Nushell configuration overlay for git

# Git command aliases
export alias amend = git commit --amend
export alias branch = git checkout -b
export alias branches = git branch --all
export alias checkout = git checkout
export alias commit = git commit
export alias rebase = git rebase
export alias remotes = git remote --verbose
export alias stage = git add
export alias stash = git stash
export alias status = git status
export alias switch = git switch
export alias unstage = git restore --staged .

# Git Large File Storage
export alias lfs = git lfs
