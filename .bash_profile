##
# PERSONAL INITIALIZATION FILE ~/.bash_profile file for GNU bash (version 4+)
#
# On Unix machines this file is executed for login shells each time you login.
# When bash is invoked as an interactive login shell, or as a non-interactive
# shell with the --login option, it first reads and executes /etc/profile, then
# it looks for ~/.bash_profile, ~/.bash_login, and ~/.profile, executing the
# first of these files that exists and is readable.
#
# OSX Terminal.app executes this file with each new Terminal window.
#
##
echo 'Loading ~/.bash_profile'

# Load shell dotfiles to complete profile configuration
# ~/.private is never commited to the repository
for file in ~/.{path,bash_prompt,aliases,exports,functions,private}; do
	[ -r "$file" ] && source "$file"
done
unset file

##
# Shell Options
# major version number ${BASH_VERSINFO[0]} or $BASH_VERSINFO
# minor version number ${BASH_VERSINFO[1]}
##
if [ $BASH_VERSINFO -ge 4 ]; then

	# execute any command that is a directory names as if it were an argument to the cd command
	shopt -s autocd

	# lists the status of any stopped and running jobs before exiting an interactive shell,
	# exit will be deferred until a second exit is attempted without an intervening command.
	shopt -s checkjobs

	# perform spelling corrections on directory names
	shopt -s dirspell

	# enable recursive globbing with **
	#shopt -s globstar
fi

# auto-correct spelling when changing directory
shopt -s cdspell

# include filenames beginning with a dot in the results of pathname expansion
shopt -s dotglob

# append to the history file when shell exits, rather than overwriting it
shopt -s histappend

# case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# patterns which do match any files expand to a null string
#shopt -s nullglob


# Bash command completion installed with Homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	source $(brew --prefix)/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

test -f ~/.git-completion.sh && source ~/.git-completion.sh

# node and npm command completion
if [ -f /usr/local/lib/node_modules/npm/lib/utils/completion.sh ]; then
	source /usr/local/lib/node_modules/npm/lib/utils/completion.sh
fi

# Rails command completions installed with Homebrew
if [ -f $(brew --prefix)/etc/bash_completion.d/rails.bash ]; then
    source $(brew --prefix)/etc/bash_completion.d/rails.bash
fi

# tab completion for SSH hostnames based on ~/.ssh/config and ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh


# virtual environment wrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

# autoenv: automatically activate virtualenv when
# changing into a directory with a .env file
if [ -f /usr/local/opt/autoenv/activate.sh ]; then
	source /usr/local/opt/autoenv/activate.sh
fi

# Load Ruby Version Manager into a shell session *as a function*
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
