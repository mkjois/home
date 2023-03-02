# If not running interactively, don't do anything
[[ $- != *i* ]] && return

test -e /etc/bashrc && source /etc/bashrc

export SSH_TAKE_FILES="${HOME}/.basebashrc"
export SSH_TAKE_FILES+=" ${HOME}/.basevimrc"
export SSH_TAKE_FILES+=" ${HOME}/.vimrc"

# Reset
Reset="$(tput sgr0)"

# Dim (doesn't work sometimes, depending on host, application, shell, etc.)
DBlack="$(tput dim)$(tput setaf 7)"
DRed="$(tput dim)$(tput setaf 1)"
DGreen="$(tput dim)$(tput setaf 2)"
DYellow="$(tput dim)$(tput setaf 3)"
DBlue="$(tput dim)$(tput setaf 4)"
DPurple="$(tput dim)$(tput setaf 5)"
DCyan="$(tput dim)$(tput setaf 6)"
DWhite="$(tput dim)$(tput setaf 7)"

# Normal
NBlack="$(tput setaf 7)"
NRed="$(tput setaf 1)"
NGreen="$(tput setaf 2)"
NYellow="$(tput setaf 3)"
NBlue="$(tput setaf 4)"
NPurple="$(tput setaf 5)"
NCyan="$(tput setaf 6)"
NWhite="$(tput setaf 7)"

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
export EMAIL="m.k.jois@gmail.com"
export CLICOLOR=1

export PATH="${PATH/\/usr\/sbin//usr/local/sbin:/usr/sbin}"

if test -d /opt/homebrew/bin ; then
    export PATH="/opt/homebrew/bin:${PATH}"
fi

path="${HOME}/bin"
if [[ ! ( ${PATH} =~ (^|:)${path}(:|$) ) ]]; then
    export PATH="${path}:${PATH}"
fi

# Git prompt
if test -e "${HOME}/git-prompt.sh"; then
    source "${HOME}/git-prompt.sh"
    export SSH_TAKE_FILES+=" ${HOME}/git-prompt.sh"
elif which -s git && test -e "$(realpath "$(which git)/../../etc/bash_completion.d/git-prompt.sh")"; then
    git_prompt_path="$(realpath "$(which git)/../../etc/bash_completion.d/git-prompt.sh")"
    source "${git_prompt_path}"
    export SSH_TAKE_FILES+=" ${git_prompt_path}"
fi

set_prompt () {
    Last="$(printf '%03d' $?)"
    PS1=''
    [[ $Last == "000" ]] && PS1+="\[$NGreen\]" || PS1+="\[$NRed\]"
    PS1+="$Last "
    [[ $EUID == 0 ]] && PS1+="\[$BRed\]" || PS1+="\[$BGreen\]"
    Branch="$(__git_ps1 "[%s]" || echo '')"
    PS1+="\u\[$NYellow\]@${HOSTNAME%%.*} \[$BPurple\]$Branch\[$BBlue\]\w\n"
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

aws() {
    docker run --rm -i \
        -v ${HOME}/.aws:/root/.aws:ro \
        -v ${HOME}/.kube:/root/.kube \
        -v "$(pwd):/aws" \
        amazon/aws-cli "$@"
}

colors() {
    str="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-+=()[]{}|'\":;,./?"
    for i in $(seq 0 7); do
        echo "$(tput dim )$(tput setaf $i)${str}$(tput sgr0)"
        echo "$(tput setaf $i)${str}$(tput sgr0)"
        echo "$(tput bold)$(tput setaf $i)${str}$(tput sgr0)"
    done
}

dive() {
    docker run --rm -it \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
        wagoodman/dive "$@"
}

fetch() {
    branch="${1:-master}"
    depth="${2:-3}"
    git fetch --depth "${depth}" origin "${branch}"
    git checkout -b "${branch}" FETCH_HEAD
    git branch --set-upstream-to "origin/${branch}"
}

ggb() {
    arg="$1"
    shift
    git grep -w "${arg}" "$@"
}

gitup() {
    branch="${1:-master}"
    git c "${branch}"
    git p
    git bd "$(git rev-parse --abbrev-ref @{-1})"
}

jq() {
    docker run --rm -i \
        -v "$(pwd):/src" \
        -w /src \
        imega/jq "$@"
}

jv() {
    version="${1:-17}"
    export JAVA_HOME="$(/usr/libexec/java_home -v "$(test "${version}" -lt 9 && echo "1.${version}" || echo "${version}")")"
}

nsb() {
    name="${1:-asdf.sh}"
    cp ~/lib/script-template-bash.sh "${name}"
    chmod +x "${name}"
}

nsp() {
    name="${1:-asdf.py}"
    cp ~/lib/script-template-python.py "${name}"
    chmod +x "${name}"
}

packer() {
    pkversion="${PK_VERSION:-1.8.6}"
    docker run --rm -it \
        -v ${HOME}/.aws:/root/.aws:ro \
        -v ${HOME}/.config/packer:/root/.config/packer \
        -v "$(pwd):/src" \
        -w /src \
        hashicorp/packer:${pkversion} "$@"
}

psql() {
    pgversion="${PG_VERSION:-12}"
    docker run --rm -i \
        postgres:${pgversion}-alpine psql "$@"
}

pssh() {
    docker run --rm -i \
        -v ${HOME}/.ssh:/root/.ssh:ro \
        -v "$(pwd):/src" \
        -w /src \
        reactivehub/pssh parallel-ssh -l ${USER} -O 'PermitLocalCommand=no' "$@"
}

serve() {
    path="${1:-.}"
    port="${2:-8080}"
    python3 -m http.server -d "${path}" -b 0.0.0.0 "${port}"
}

terraform() {
    tfversion="${TF_VERSION:-1.3.9}"
    docker run --rm -i \
        -v ${HOME}/.aws:/root/.aws:ro \
        -v ${HOME}/.ssh:/root/.ssh:ro \
        -v ${HOME}/.terraform.d:/root/.terraform.d \
        -v "$(pwd):/src" \
        -w /src \
        hashicorp/terraform:${tfversion} "$@"
}

total() {
    awk '{sum += $1} END {print sum}'
}

# stop exporting stuff
set +a

alias g="echo -e '\n===== BRANCHES =====\n' && git branch && echo -e '\n===== LATEST =====\n' && git --no-pager log -n 2 && echo -e '\n===== STATUS =====\n' && git status -sb && echo"
alias gd='git diff'
alias gp='gpg --sign -u "${USER}" -o /dev/null ~/.gitmessage'
alias rgl='rm -rfv ~/.go'
alias rml='rm -rfv ~/.m2'

# Docker convenience
alias d="echo -e '\n===== CONTAINERS =====\n' && docker container ls -a && echo -e '\n===== IMAGES =====\n' && docker image ls | egrep -v '^registry\\.k8s\\.io\\/' | egrep -v '^k8s\\.gcr\\.io\\/' | egrep -v '^docker\\/' | egrep -v '^hubproxy\\.docker\\.internal:5000\\/' | LC_COLLATE=C sort -k 1 && echo"
alias dr='docker run --rm -it -w /src -v "$(pwd):/src"'
alias dcat='docker run --rm -i -w /src -v "$(pwd):/src"'
alias dgc='docker system prune --volumes'

# Vim convenience
alias v='vim -p'
alias vimup='for d in $(find ~/.vim/bundle -type d -depth 1); do pushd $d > /dev/null && git pull && popd > /dev/null; done'

# SSH convenience
alias sshp='ssh-plus.sh'
alias sgc='rm -fv ~/.ssh/sockets/*'

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
