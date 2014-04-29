##
# Homebrew
#
# Running `brew bundle` with this file will invoke each line as a brew command.
#
# Running `brew leaves` will show installed formulae that are not dependencies
# of another installed formula. To generate a base Brewfile run:
#
# 	`brew tap | sed 's/^/tap /' > Brewfile`
# 	`brew leaves | sed 's/^/install /' > Brewfile`
##

## Make sure we're using the latest Homebrew
update

## Upgrade any all-ready installed formulae
upgrade

## Additional Homebrew repositories
tap homebrew/completions
tap homebrew/dupes
tap homebrew/science
tap homebrew/versions

## Old compilers required by formula such as tcl-tk
install apple-gcc42

## Newer versions of OSX installed tools
install openssl && brew link --force openssl

install curl --with-openssl --with-ssh
install homebrew/dupes/grep
install homebrew/dupes/rsync

## Unix shells
install bash
install fish
install zsh

## Extend tab completions
install bash-completion
install zsh-completions

install homebrew/completions/django-completion
install homebrew/completions/rails-completion
install homebrew/completions/rake-completion
install homebrew/completions/vagrant-completion

## Update and extend git
install git
install git-flow-avh
install hub

## Useful binaries
install ack
install asciidoc
install browser
install ctags
install enchant
install exiftool
install fontforge
install gfortran
install giflib
install graphicsmagick
install imagemagick
install libksba
install liblqr
install librsvg
install libxslt
install libyaml
install little-cms2
install node
install markdown
install osxfuse
install putty
install rename
install shocco
install sshuttle
install terminal-notifier
install tmux
install tree
install vcprompt
install webkit2png
install wget

## Databases & adapters
install freetds
install libpqxx
install mongodb
install mysql
install postgres
install sqlite

## Remove outdated versions from the Cellar
cleanup
