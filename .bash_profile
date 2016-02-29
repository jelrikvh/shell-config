export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

RED="\033[0;31m"
GREEN="\033[0;32m"
GREENBOLD="\033[1;32m"
YELLOW="\033[0;33m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
RESETCOLOR="\033[m"

function prompt_exitcode {
  local EXITCODE=$?
  if [ $EXITCODE -eq 0 ]; then
      echo -en "${GREEN}✔${RESETCOLOR}"
  else
      echo -en "${RED}✘-${EXITCODE}${RESETCOLOR}"
  fi
}

function prompt_pwd {
  echo -en "${PURPLE}$( pwd )${RESETCOLOR}"
}

function prompt_git {
  # git part
  local git_status="$(git status -unormal 2>&1)"
  if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
    local BRANCH="detached"
    if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
      BRANCH=${BASH_REMATCH[1]}
    fi

    echo -en " [${YELLOW}${BRANCH}${RESETCOLOR}|"
    if [[ "$git_status" =~ nothing\ to\ commit ]]; then
      echo -en "${GREEN}✔"
    else
      if [[ "$git_status" =~ Changes\ to\ be\ committed: ]]; then
        echo -en "${YELLOW}●"
      fi
      if [[ "$git_status" =~ Changes\ not\ staged\ for\ commit: ]]; then
        echo -en "${GREEN}✚"
      fi
      if [[ "$git_status" =~ Untracked\ files: ]]; then
        echo -en "${CYAN}…"
      fi
    fi 
    echo -en "${RESETCOLOR}]"
  fi
}

function prompt_prompt {
  echo -en "${GREEN}→ ${RESETCOLOR}"
}

function prompt_continued {
  echo -en "${GREEN} | ${RESETCOLOR}"
}
 
function prompt { 
  export PS1="\$(prompt_exitcode) \$(prompt_pwd)\$(prompt_git)\n \$(prompt_prompt)" 
  export PS2="\$(prompt_continued)"
}

prompt

alias ls='ls -althrsF'
alias gtst='git status'

