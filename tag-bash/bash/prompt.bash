#!/usr/bin/env bash

##
# custom bash command prompt
##

function before_prompt {
  virtualenv_info
  printf '\n'
}

# trim working directory to 1/4 the screen width
function trim_working_dir {
  local maxlength=$(($COLUMNS/4))
  if [[ $PWD == $HOME* ]]; then
    working_dir="~${PWD#$HOME}"
  else
    working_dir=${PWD}
  fi
  if [ ${#working_dir} -gt $maxlength ]; then
    local offset=$(( ${#working_dir} - $maxlength + 3 ))
    working_dir="...${working_dir:$offset:$maxlength}"
  fi
  echo $working_dir
}

# determine active python virtual environment
function virtualenv_info {
  if [[ -n $VIRTUAL_ENV ]]; then
    # macOS Terminal: set tab title to path stripped virtualenv name
    printf '\e]1;%s\a' "[venv:${VIRTUAL_ENV##*/}]"
  else
    # no active virtualenv
    # macOS Terminal: clear tab title and window title
    printf '\e]1;%s\a' ''
  fi
}

PROMPT_COMMAND=before_prompt
PROMPT_DIRTRIM=3

# fix prompt after Control-C
# PS1="\033[G$PS1"

export VCPROMPT_FORMAT="on %b %m%u [%r]"
export PS1='\u at \h in \w $(vcprompt)\n→ '
export PS2='↪ '

export PROMPT_COMMAND
