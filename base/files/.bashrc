# If not running interactively, don't do anything
[[ $- != *i* ]] && return

test -e /etc/bashrc && source /etc/bashrc

# Reset
Reset="$(tput sgr0)"

# Dim
DBlack="$(tput dim)$(tput setaf 7)"
DRed="$(tput dim)$(tput setaf 1)"
DGreen="$(tput dim)$(tput setaf 2)"
DYellow="$(tput dim)$(tput setaf 3)"
DBlue="$(tput dim)$(tput setaf 4)"
DPurple="$(tput dim)$(tput setaf 5)"
DCyan="$(tput dim)$(tput setaf 6)"
DWhite="$(tput dim)$(tput setaf 7)"

# Bold
BBlack="$(tput bold)$(tput setaf 7)"
BRed="$(tput bold)$(tput setaf 1)"
BGreen="$(tput bold)$(tput setaf 2)"
BYellow="$(tput bold)$(tput setaf 3)"
BBlue="$(tput bold)$(tput setaf 4)"
BPurple="$(tput bold)$(tput setaf 5)"
BCyan="$(tput bold)$(tput setaf 6)"
BWhite="$(tput bold)$(tput setaf 7)"

export NAME="Manny Jois"
export EMAIL="mjois@quantcast.com"
export CLICOLOR=1

export PATH="${PATH/\/usr\/sbin//usr/local/sbin:/usr/sbin}"

path="${HOME}/bin"
if [[ ! ( ${PATH} =~ (^|:)${path}(:|$) ) ]]; then
    export PATH="${path}:${PATH}"
fi

# Git prompt
if test -e ~/lib/git-prompt.sh; then
    source ~/lib/git-prompt.sh
elif test -e /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh; then
    source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi

set_prompt () {
    Last="$(printf '%03d' $?)"
    PS1=''
    [[ $Last == "000" ]] && PS1+="\[$DGreen\]" || PS1+="\[$DRed\]"
    PS1+="$Last "
    [[ $EUID == 0 ]] && PS1+="\[$BRed\]" || PS1+="\[$BGreen\]"
    Branch="$(__git_ps1 "[%s]" || echo '')"
    PS1+="\u\[$DYellow\]@${HOSTNAME%%.*} \[$BPurple\]$Branch\[$BBlue\]\w\n"
    [[ $EUID == 0 ]] && PS1+="\[$BRed\]" || PS1+="\[$BGreen\]"
    PS1+="\$ \[$BBlack\]"
    [[ $EUID == 0 ]] && PS2="\[$BRed\]> \[$BBlack\]" || PS2="\[$BGreen\]> \[$BBlack\]"
    [[ $EUID == 0 ]] && PS4="\[$BRed\]+ \[$BBlack\]" || PS4="\[$BGreen\]+ \[$BBlack\]"
}
PROMPT_COMMAND='set_prompt'

# Reset color after command is entered
trap 'echo -ne $Reset' DEBUG

# Send signal to rewrap text on window size change
shopt -s checkwinsize

# Command history
shopt -s cmdhist
shopt -s histappend
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTCONTROL=ignoreboth
export HISTIGNORE='d:g:l:la:ll:lr:ls:bg:fg:jobs:clear:reset:exit:history'

# export functions for use in scripts
set -a

colors() {
    str="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-+=()[]{}|'\":;,./?"
    for i in $(seq 0 7); do
        echo "$(tput dim )$(tput setaf $i)${str}$(tput sgr0)"
        echo "$(tput bold)$(tput setaf $i)${str}$(tput sgr0)"
    done
}

fetch() {
    branch="${1:-master}"
    depth="${2:-3}"
    git fetch --depth "${depth}" origin "${branch}"
    git checkout -b "${branch}" FETCH_HEAD
    git branch --set-upstream-to "origin/${branch}"
}

gitup() {
    branch="${1:-master}"
    git checkout "${branch}"
    git pull
    git branch -D "$(git rev-parse --abbrev-ref @{-1})"
}

psql() {
    pgversion="${PG_VERSION:-12}"
    docker run --rm -i \
        postgres:${pgversion}-alpine psql "$@"
}

serve() {
    path="${1:-.}"
    port="${2:-8080}"
    python3 -m http.server -d "${path}" -b 0.0.0.0 "${port}"
}

total() {
    awk '{sum += $1} END {print sum}'
}

# stop exporting stuff
set +a

alias g="echo -e '\n===== BRANCHES =====\n' && git branch && echo -e '\n===== LATEST =====\n' && git --no-pager log -n 2 && echo -e '\n===== STATUS =====\n' && git status -sb && echo"
alias rml="rm -rfv ~/.m2"

# Docker convenience
alias d="echo -e '\n===== CONTAINERS =====\n' && docker ps -a && echo -e '\n===== IMAGES =====\n' && docker images | egrep -v '^k8s\\.gcr\\.io\\/' | egrep -v '^docker\\/' | sort -k 1 && echo"
alias dr='docker run --rm -it -w /src -v "$(pwd):/src"'
alias dcat='docker run --rm -i -w /src -v "$(pwd):/src"'
alias docktor="docker system prune --volumes"

# Vim convenience
alias v='vim -p'
alias vimup='for d in $(find ~/.vim/bundle -type d -depth 1); do pushd $d > /dev/null && git pull && popd > /dev/null; done'

# Commands with color
alias grep=' grep  --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Extra ls aliases
alias l=' ls -AlF'
alias lr='ls -AlFR'

# cd's
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
