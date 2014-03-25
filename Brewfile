##
# Homebrew
#
# Run `brew leaves` to show installed formulae that are not dependencies of
# another installed formula.
#
# Generate a base Brewfile with `brew leaves | sed 's/^/install /' > Brewfile`
#
##

# Make sure we're using the latest Homebrew
update

# Upgrade any all-ready installed formulae
upgrade

# Additional Homebrew repositories
tap homebrew/completions
tap homebrew/dupes
tap homebrew/science
tap homebrew/versions

# Updated OSX tools
install apple-gcc42
install curl --with-openssl --with-ssh
install gcc46
install grep

install openssl
link -f openssl

# Unix shells
install bash
install fish
install zsh 

# Extend tab completions
install bash-completion
install zsh-completions

install django-completion
install rails-completion
install rake-completion
install vagrant-completion

# Update and extend git
install git
install git-flow-avh
install hub

# Useful binaries
install ack
install ctags
install exiftool
install graphicsmagick
install hub
install heroku-toolbelt
install imagemagick
install node
install most
install pkg-config
install putty
install rename
install terminal-notifier
install tree
install vcprompt
install webkit2png
install wget

# Java tools
install checkstyle
install findbugs

# Update PHP
tap josegonzalez/php
install php56 --with-homebrew-openssl --with-pgsql --with-tidy
install php56-imagick
install php56-intl
install php56-mongo
install php56-twig
install php56-xdebug
install phpunit
install composer

# Update Python, SciPy & NumPy
install python --with-brewed-openssl --with-brewed-tk
install python3 --with-brewed-openssl --with-brewed-tk
install autoenv

tap samueljohn/python
install scipy
install numpy --with-python3

# Databases & adapters
install freetds
install mongodb
install mysql
install postgres
install sqlite

# Database web interfaces
install phpmyadmin
install phppgadmin

# Remove outdated versions from the Cellar
cleanup
