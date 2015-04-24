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
tap homebrew/apache
tap homebrew/completions
tap homebrew/dupes
tap homebrew/science
tap homebrew/versions

## Replacement for the removed Homebrew services command
tap gapple/services

## Old compilers required by formula such as tcl-tk
install apple-gcc42

## Newer versions of OSX installed tools
install openssl && brew link --force openssl

install curl --with-openssl --with-ssh
install homebrew/dupes/grep
install homebrew/dupes/rsync

## Command line shells
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
install fcgi
install ffmpeg --with-tools
install fontforge
install gfortran
install go
install libksba
install libxslt
install libyaml
install lighttpd
install little-cms2
install markdown
install maven
install mediainfo
install mod_fastcgi
install mod_fcgi
install nginx --with-passenger
install ngrok
install node
install osxfuse
install passenger
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

# Image processing tools
install exiftool
install giflib
install graphicsmagick
install imagemagick
install liblqr
install librsvg
install opencv
install vips --with-cfitsio --with-graphicsmagick --with-imagemagic --with-openexr --with-openslide --with-webp

# MacGPG (install GPGTools using Homebrew Cask)
install gpg2 --8192 --with-readline

## Databases & adapters
install freetds
install jena
install libpqxx
install mongodb
install mysql
install orientdb
install postgres
install redis
install sqlite

## Search Appliances
install elasticsearch
install solr

## Android application development
install android-sdk
install ant

## Remove outdated versions from the Cellar
cleanup
