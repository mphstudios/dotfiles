#
# PERSONAL INITIALIZATION FILE ~/.bash_profile file for GNU bash (version 4+)
#
# On Unix machines this file is executed for login shells each time you login.
#
# When bash is invoked as an interactive login shell, or as a non-interactive
# shell with the --login option, it first reads and executes commands from the
# file/etc/profile, then looks for ~/.bash_profile, ~/.bash_login, ~/.profile,
# executing the first of these files that exists and is readable.
#
# Non-login interactive bash shells (subshells) will only read ~/.bashrc unless
# the --login option is specified.
#
# OSX Terminal.app executes ~/.bash_profile with each new Terminal window.
#
#
#echo "Loading login shell configuration from $HOME/.bash_profile"

# Load shell agnostic configuration
#[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# Load interactive shell configuration
[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

# Load additional shell profile configurations
for file in ~/.{exports,path,bash_prompt,aliases,functions,private}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset -v file

# Load command completions
if [ -r $(brew --prefix)/share/bash-completion/bash_completion ]; then
  source $(brew --prefix)/share/bash-completion/bash_completion
fi

# Load command completions for node and npm commands
if [ -r /usr/local/lib/node_modules/npm/lib/utils/completion.sh ]; then
    source /usr/local/lib/node_modules/npm/lib/utils/completion.sh
fi

# Complete SSH hostnames based on ~/.ssh/config (wildcards ignored)
if [ -r "$HOME/.ssh/config" ]; then
    complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh
fi

# Load Ruby Version Manager into the shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if [ -r "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

eval "$(thefuck --alias)"
