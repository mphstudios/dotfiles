##
# Homebrew Bundle
# https://github.com/Homebrew/homebrew-bundle
#
# Running `brew leaves` will show installed formulae that are not dependencies
# of another installed formula.
#
# To generate a base Brewfile run the following commands:
#
# 	`brew tap | sed "s/^.*/tap '&'/" > Brewfile`
# 	`brew leaves | sed "s/^.*/brew '&'/" >> Brewfile`
#
# To generate a Brewfile listing all installed packages and casks, including
# dependecies, run the command `brew bundle dump -f > Brewfile`
#
# This Brewfile can also be used as a whitelist and uninstall all Homebrew
# formulae not listed in Brewfile run the command `brew bundle cleanup`
#
##

## Additional Homebrew repositories
tap 'homebrew/apache'
tap 'homebrew/completions'
tap 'homebrew/dupes'
tap 'homebrew/science'
tap 'homebrew/versions'

## Replacement for the removed Homebrew services command
tap 'gapple/services'

## Old compilers required by formula such as tcl-tk
brew 'apple-gcc42'

## Newer versions of OSX installed tools
brew 'openssl && brew link --force openssl'

brew 'curl', args: [ 'with-openssl', 'with-ssh' ]
brew 'homebrew/dupes/grep'
brew 'homebrew/dupes/rsync'

## GNU Bourne Again SHell
brew 'bash'
brew 'bash-completion'
brew 'django-completion'
brew 'grunt-completion'

# Bash command-line completion for Ruby commands
brew 'bundler-completion'
brew 'gem-completion'
brew 'rails-completion'
brew 'rake-completion'
brew 'ruby-completion'

## alternate command-line shells
brew 'fish'
brew 'zsh'
brew 'zsh-completions'

## Update and extend git
brew 'git'
brew 'git-flow-avh'
brew 'hub'

## Useful binaries
brew 'ack'
brew 'asciidoc'
brew 'browser'
brew 'ctags'
brew 'enchant'
brew 'fcgi'
brew 'ffmpeg', args: [ 'with-tools' ]
brew 'fontforge'
brew 'gfortran'
brew 'go'
brew 'libksba'
brew 'libxslt'
brew 'libyaml'
brew 'lighttpd'
brew 'little-cms2'
brew 'markdown'
brew 'maven'
brew 'mediainfo'
brew 'mod_fastcgi'
brew 'mod_fcgi'
brew 'nginx', args: [ 'with-passenger' ]
brew 'ngrok'
brew 'node'
brew 'osxfuse'
brew 'passenger'
brew 'putty'
brew 'rename'
brew 'shocco'
brew 'sshuttle'
brew 'terminal-notifier'
brew 'tree'
brew 'vcprompt'
brew 'webkit2png'
brew 'wget'

# Image processing tools
brew 'exiftool'
brew 'giflib'
brew 'graphicsmagick'
brew 'imagemagick'
brew 'liblqr'
brew 'librsvg'
brew 'opencv'
brew 'vips', args: [ 'with-cfitsio',  'with-graphicsmagick',  'with-imagemagic',  'with-openexr',  'with-openslide',  'with-webp' ]

# MacGPG (brew 'GPGTools using Homebrew Cask)'
brew 'gpg2', args: [ '8192', 'with-readline' ]

## Databases & adapters
brew 'freetds'
brew 'jena'
brew 'libpqxx'
brew 'mongodb'
brew 'mysql'
brew 'orientdb'
brew 'postgres'
brew 'redis'
brew 'sqlite'

## Search Appliances
brew 'elasticsearch'
brew 'solr'

## Android application development
brew 'android-sdk'
brew 'ant'
