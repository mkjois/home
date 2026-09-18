# If not running interactively, don't do anything
[[ $- != *i* ]] && return

test -e /etc/bashrc && source /etc/bashrc

export SSH_TAKE_FILES="${HOME}/.basebashrc"
export SSH_TAKE_FILES+=" ${HOME}/.basevimrc"
export SSH_TAKE_FILES+=" ${HOME}/.vimrc"
export SSH_TAKE_FILES+=" ${HOME}/bin"
export SSH_TAKE_FILES+=" ${HOME}/lib"

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

default_java_version=25
default_git_fetch_depth=5

# Kinda weird chicken and egg problem, but okay.
if test -d /opt/homebrew/bin ; then
    brew_prefix="$(/opt/homebrew/bin/brew --prefix)"
    if test -d "${brew_prefix}/bin" ; then
        export PATH="${brew_prefix}/bin:${brew_prefix}/sbin:${PATH}"
    fi
fi

# Java toolchain
if /usr/libexec/java_home -v ${default_java_version} > /dev/null 2> /dev/null; then
    export JAVA_HOME="$(/usr/libexec/java_home -v ${default_java_version})"
fi

# Go toolchain
export GOPATH="${HOME}/src/go"
export GOTOOLCHAIN="${GOTOOLCHAIN:-auto}"

# Rust toolchain
if test -e "${HOME}/.cargo/env"; then
    source "${HOME}/.cargo/env"
fi

# Orbstack setup
if test -e "${HOME}/.orbstack/shell/init.bash"; then
    source "${HOME}/.orbstack/shell/init.bash" 2> /dev/null
fi

# Random programs that decide to install to `~/.local/`
path="${HOME}/.local/bin"
if [[ ! ( ${PATH} =~ (^|:)${path}(:|$) ) ]]; then
    export PATH="${path}:${PATH}"
fi

# Rust programs
path="${HOME}/.cargo/bin"
if [[ ! ( ${PATH} =~ (^|:)${path}(:|$) ) ]]; then
    export PATH="${path}:${PATH}"
fi

# Go project binaries
path="${GOPATH}/bin"
if [[ ! ( ${PATH} =~ (^|:)${path}(:|$) ) ]]; then
    export PATH="${path}:${PATH}"
fi

# Locally built and installed binaries
path="${HOME}/bin"
if [[ ! ( ${PATH} =~ (^|:)${path}(:|$) ) ]]; then
    export PATH="${path}:${PATH}"
fi

# Git prompt
if which git > /dev/null 2> /dev/null && test -e "$(realpath "$(which git)/../../etc/bash_completion.d/git-prompt.sh" 2> /dev/null)" > /dev/null 2> /dev/null ; then
    git_prompt_path="$(realpath "$(which git)/../../etc/bash_completion.d/git-prompt.sh" 2> /dev/null)"
    export SSH_TAKE_FILES+=" ${git_prompt_path}"
elif test -e "${HOME}/lib/git-prompt.sh"; then
    source "${HOME}/lib/git-prompt.sh"
    export SSH_TAKE_FILES+=" ${HOME}/lib/git-prompt.sh"
fi

# Git completion
if which git > /dev/null 2> /dev/null && test -e "$(realpath "$(which git)/../../etc/bash_completion.d/git-completion.bash" 2> /dev/null)" > /dev/null 2> /dev/null ; then
    git_completion_path="$(realpath "$(which git)/../../etc/bash_completion.d/git-completion.bash" 2> /dev/null)"
    export SSH_TAKE_FILES+=" ${git_completion_path}"
elif test -e "${HOME}/lib/git-completion.bash"; then
    source "${HOME}/lib/git-completion.bash"
    export SSH_TAKE_FILES+=" ${HOME}/lib/git-completion.bash"
fi

# Load all autocompletions
if which brew > /dev/null 2> /dev/null ; then
    brew_prefix="$(brew --prefix)"
    if test -r "${brew_prefix}/etc/profile.d/bash_completion.sh" ; then
        source "${brew_prefix}/etc/profile.d/bash_completion.sh"
    fi
fi

# Docker completion
if which docker  > /dev/null 2> /dev/null && ! complete -p docker  > /dev/null 2> /dev/null ; then
    source <(docker completion bash)
fi

# Kubernetes completion
if which kubectl > /dev/null 2> /dev/null && ! complete -p kubectl > /dev/null 2> /dev/null ; then
    source <(kubectl completion bash)
fi

# Orbstack completion
if which orbctl  > /dev/null 2> /dev/null && ! complete -p orbctl  > /dev/null 2> /dev/null ; then
    source <(orbctl completion bash)
fi

# Podman completion
if which podman  > /dev/null 2> /dev/null && ! complete -p podman  > /dev/null 2> /dev/null ; then
    source <(podman completion bash)
fi

# Start a GPG agent for forwarding.
if which gpg > /dev/null 2> /dev/null ; then
    true
    #gpg -k
    #if which gpg-agent > /dev/null 2> /dev/null && ! gpg-agent status ; then
    #    gpg-agent --daemon
    #fi
    #if test -r "${HOME}/pubring.gpg.txt" ; then
    #    gpg --import "${HOME}/pubring.gpg.txt"
    #fi
fi

# Super awesome custom prompt with all kinds of information.
set_prompt() {
    _last="$(printf '%03d' $?)"
    _time_cmd_end="$(date +%s)"
    _time_cmd_diff="$((${_time_cmd_end} - ${_time_cmd_start}))"

    PS1=''
    [[ ${_last} == "000" ]] && PS1+="\[$NGreen\]" || PS1+="\[$NRed\]"
    PS1+="${_last} \[$NCyan\]${_time_cmd_diff}s "
    [[ ${EUID} == 0 ]] && PS1+="\[$BRed\]" || PS1+="\[$BGreen\]"
    _branch="$(__git_ps1 "[%s]" || echo '')"
    PS1+="\u\[$NYellow\]@${HOSTNAME%%.*} \[$BPurple\]$_branch\[$BBlue\]\w\n"
    [[ ${EUID} == 0 ]] && PS1+="\[$BRed\]" || PS1+="\[$BGreen\]"
    PS1+="\$ \[$BBlack\]"
    [[ ${EUID} == 0 ]] && PS2="\[$BRed\]> \[$BBlack\]" || PS2="\[$BGreen\]> \[$BBlack\]"
    [[ ${EUID} == 0 ]] && PS4="\[$BRed\]+ \[$BBlack\]" || PS4="\[$BGreen\]+ \[$BBlack\]"

    _time_cmd_diff=0
}
PROMPT_COMMAND='set_prompt'

# Start timer and reset color after command is entered.
run_hook() {
    _time_cmd_start="$(date +%s)"
    echo -ne "$Reset"
}
trap 'run_hook' DEBUG

# Send signal to rewrap text on window size change.
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

cg() {
    local repo="${1:-NONE}"
    local matching_dirs="$(find "${GOPATH}/src" -type d -maxdepth 4 -name '\.git' | grep -E "/${repo}[^/]*/\.git\$")"
    if echo -e "${matching_dirs}" | grep -qE '^$'; then
        echo -e "\nNo repos found: ${repo}*\n" >&2
        return 1
    elif test "$(echo -e "${matching_dirs}" | wc -l | awk '{print $1}')" -eq 1; then
        cd "$(dirname "${matching_dirs}")"
    else
        local prefix_to_remove="$(echo "${GOPATH}/src/" | sed 's/\//\\\//g')"
        echo -e "\nAmbiguous:\n$(echo -e "${matching_dirs}" | sed 's/\/\.git$//' | sed "s/^${prefix_to_remove}/ - /")\n" >&2
        return 1
    fi
}

colors() {
    local str="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-+=()[]{}|'\":;,./?"
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

draw() {
    local encoded="$(cat "$1" | python3 -c 'import sys; import urllib.parse; print(urllib.parse.quote(sys.stdin.read()))')"
    local link="https://TODO-mermaid-host/generate?data=${encoded}"
    echo "${link}"
    open "${link}"
}

fetch() {
    local branch="${1:-master}"
    local depth="${2:-${default_git_fetch_depth}}"
    git fetch --depth "${depth}" origin "${branch}"
    git checkout -b "${branch}" FETCH_HEAD
    git branch --set-upstream-to "origin/${branch}"
}

ggb() {
    local arg="$1"
    shift
    git grep -w "${arg}" "$@"
}

gitup() {
    local branch="${1:-master}"
    git c "${branch}"
    git p
    git bd "$(git rev-parse --abbrev-ref @{-1})"
}

jv() {
    local version="${1:-${default_java_version}}"
    export JAVA_HOME="$(/usr/libexec/java_home -v "$(test "${version}" -lt 9 && echo "1.${version}" || echo "${version}")")"
}

newpr() {
    if test "$1"; then
        open "https://github.com/$(git remote get-url origin | cut -d ':' -f 2 | cut -d '.' -f 1)/compare/$1...$(git branch | grep \* | cut -d ' ' -f 2)"
    else
        open "https://github.com/$(git remote get-url origin | cut -d ':' -f 2 | cut -d '.' -f 1)/compare/$(git branch | grep \* | cut -d ' ' -f 2)"
    fi
}

nsb() {
    local name="${1:-asdf.sh}"
    cp ~/lib/script-template-bash.sh "${name}"
    chmod +x "${name}"
}

nsp() {
    local name="${1:-asdf.py}"
    cp ~/lib/script-template-python.py "${name}"
    chmod +x "${name}"
}

packer() {
    local pkversion="${PK_VERSION:-1.16.1}"
    docker run --rm -it \
        -v ${HOME}/.aws:/root/.aws:ro \
        -v ${HOME}/.config/packer:/root/.config/packer \
        -v "$(pwd):/src" \
        -w /src \
        hashicorp/packer:${pkversion} "$@"
}

pssh() {
    docker run --rm -i \
        -v ${HOME}/.ssh:/root/.ssh \
        -v "$(pwd):/src" \
        -w /src \
        reactivehub/pssh parallel-ssh -l ${USER} -O 'PermitLocalCommand=no' "$@"
}

serve() {
    local path="${1:-.}"
    local port="${2:-8080}"
    python3 -m http.server -d "${path}" -b 0.0.0.0 "${port}"
}

servegt() {
    local path="${1:-.}"
    set="${2:-test}"
    local port="${3:-8080}"
    python3 -m http.server -d "${path}/build/reports/tests/${set}/" -b 0.0.0.0 "${port}"
}

terraform() {
    local tfversion="${TF_VERSION:-1.16.3}"
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

vault() {
    vtversion="${VT_VERSION:-2.1.1}"
    address="${VAULT_ADDR:-https://TODO-vault-host}"
    docker run --rm -it \
        --entrypoint '' \
        -e "USER=${USER}" \
        -e "VAULT_ADDR=${address}" \
        -v "$(pwd):/src" \
        -v ${HOME}/.vault-root:/root \
        -w /src \
        hashicorp/vault:${vtversion} vault "$@"
}

yq() {
    docker run --rm -i \
        -v "$(pwd):/workdir" \
        mikefarah/yq "$@"
}

# stop exporting stuff
set +a

alias g="echo -e '\n===== BRANCHES =====\n' && git branch && echo -e '\n===== LATEST =====\n' && git --no-pager log -n 2 && echo -e '\n===== STATUS =====\n' && git status -sb && echo"
alias gd='git diff'
alias gp='gpg --sign -u "${EMAIL}" -o /dev/null ~/.gitmessage'
alias rgl='rm -rfv ~/.go'
alias rml='rm -rfv ~/.m2'

# Brew convenience
alias upcask="brew outdated --cask --greedy --quiet | sort"
alias upcask2="brew upgrade --cask \$(brew list --cask -1 --full-name | sort | tr '\n' ' ')"
alias upcask3="casks=\"\$(brew outdated --cask --greedy --quiet | sort | tr '\n' ' ')\"; brew uninstall --cask \${casks} ; brew install --cask \${casks}"

# Docker convenience
alias d="echo -e '\n===== CONTAINERS =====\n' && docker container ls -a && echo -e '\n===== IMAGES =====\n' && docker image ls | head -n 1 && docker image ls | grep -vE '^REPOSITORY ' | grep -vE '^registry\\.k8s\\.io\\/' | grep -vE '^docker\/' | LC_COLLATE=C sort -k 1 && echo"
alias dup="docker image ls | grep -vE '^REPOSITORY ' | grep -vE '^registry\\.k8s\\.io\\/' | grep -vE '^docker\/' | LC_COLLATE=C sort -k 1 | grep ' latest ' | awk '{print \$1}' | xargs -L 1 docker image pull"
alias dr='docker run --rm -it -w /src -v "$(pwd):/src"'
alias dcat='docker run --rm -i -w /src -v "$(pwd):/src"'
alias dgc='docker system prune --volumes && docker volume ls -q -f dangling=true | xargs docker volume rm'
alias dsock="sudo ln -sf \$(docker context ls | grep -E '^[a-zA-Z0-9_-]+ \\*' | awk '{print \$4}' | sed -r -e 's|^unix://||') /var/run/docker.sock"

# Vim convenience
alias v='vim -p'
alias vimup='for d in $(find ~/.vim/bundle -type d -depth 1); do pushd $d > /dev/null && git p && popd > /dev/null; done'
alias vsk='mkdir -p ~/tmp && v ~/tmp/skratch.txt'

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

# Miscellany
alias fp='~/src/foss/brendangregg/FlameGraph/stackcollapse-perf.pl | ~/src/foss/brendangregg/FlameGraph/flamegraph.pl'
