##
# PERSONAL INITIALIZATION FILE ~/.bash_profile file for GNU bash (version 4+)
#
# On Unix machines this file is executed for login shells each time you login.
#
# When bash is invoked as an interactive login shell, or as a non-interactive
# shell with the --login option, it first reads and executes /etc/profile, then
# it looks for ~/.bash_profile, ~/.bash_login, and ~/.profile, executing the
# first of these files that exists and is readable.
#
# Non-login interactive bash shells (subshells) will only read ~/.bashrc unless
# the --login option is specified.
#
# OSX Terminal.app executes ~/.bash_profile with each new Terminal window.
#
##
echo 'Loading ~/.bash_profile'

# Load dotfiles into shell profile configuration
# .private is never committed to the repository
for file in ~/.{path,bash_prompt,exports,python,aliases,completions,functions,private}; do
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

# Load Ruby Version Manager into the shell session as a function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
	source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi
