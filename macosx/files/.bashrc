test -e ~/.basebashrc && source ~/.basebashrc

export SSH_TAKE_FILES+=" ${HOME}/.bashrc"
export SSH_TAKE_FILES+=" ${HOME}/.gitignore"
export SSH_TAKE_FILES+=" ${HOME}/.gitmessage"
export SSH_TAKE_FILES+=" ${HOME}/.gitconfig"

# iTerm2 integrations
if test -f "${HOME}/.iterm2_shell_integration.bash"; then
    source "${HOME}/.iterm2_shell_integration.bash"
fi

# export functions for use in scripts
set -a

aws() {
    aws-docker.sh "$@"
}

draw() {
    encoded="$(cat "$1" | python3 -c 'import sys; import urllib.parse; print(urllib.parse.quote(sys.stdin.read()))')"
    link="https://TODO-mermaid-host/generate?data=${encoded}"
    echo "${link}"
    open "${link}"
}

kafka() {
    kfversion="${KF_VERSION:-2.12-2.4.1}"
    docker run --rm -it \
        -v "$(pwd):/src" \
        -w /src \
        wurstmeister/kafka:${kfversion} "$@"
}

newpr() {
    if test "$1"; then
        open "https://github.com/$(git remote get-url origin | cut -d ':' -f 2 | cut -d '.' -f 1)/compare/$1...$(git branch | grep \* | cut -d ' ' -f 2)"
    else
        open "https://github.com/$(git remote get-url origin | cut -d ':' -f 2 | cut -d '.' -f 1)/compare/$(git branch | grep \* | cut -d ' ' -f 2)"
    fi
}

oce() {
    day="$(TZ=Europe/London date +%u)"
    hour="$(TZ=Europe/London date +%H)"
    if test "${1}" = 'prev'; then
        extra_shift='-v -7d'
    else
        extra_shift=''
    fi
    if test "${day}" -eq 2; then
        if test "${hour}" -lt 14; then
            start="$(TZ=Europe/London date -v -7d ${extra_shift} '+%Y-%m-%d')"
            end="$(TZ=Europe/London date ${extra_shift} '+%Y-%m-%d')"
        else
            start="$(TZ=Europe/London date ${extra_shift} '+%Y-%m-%d')"
            end="$(TZ=Europe/London date -v +7d ${extra_shift} '+%Y-%m-%d')"
        fi
    else
        start="$(TZ=Europe/London date -v -Tue ${extra_shift} '+%Y-%m-%d')"
        end="$(TZ=Europe/London date -v +Tue ${extra_shift} '+%Y-%m-%d')"
    fi
    url="https://TODO-jira-host/issues/?jql=issuetype%20%3D%20Ticket%20AND%20created%20%3E%3D%20%22${start}%2014%3A00%22%20AND%20created%20%3C%20%22${end}%2014%3A00%22%20AND%20project%20%3D%20%22UTS%20Bidder%20Services%22%20ORDER%20BY%20created%20DESC"
    open "${url}"
}

ocb() {
    day="$(TZ=Europe/London date +%u)"
    hour="$(TZ=Europe/London date +%H)"
    minute="$(TZ=Europe/London date +%M)"
    if test "${1}" = 'prev'; then
        extra_shift='-v -7d'
    else
        extra_shift=''
    fi
    if test "${day}" -eq 2; then
        if test "${hour}" -lt 17 || (test "${hour}" -eq 17 && test "${minute}" -lt 30) ; then
            start="$(TZ=Europe/London date -v -7d ${extra_shift} '+%Y-%m-%d')"
            end="$(TZ=Europe/London date ${extra_shift} '+%Y-%m-%d')"
        else
            start="$(TZ=Europe/London date ${extra_shift} '+%Y-%m-%d')"
            end="$(TZ=Europe/London date -v +7d ${extra_shift} '+%Y-%m-%d')"
        fi
    else
        start="$(TZ=Europe/London date -v -Tue ${extra_shift} '+%Y-%m-%d')"
        end="$(TZ=Europe/London date -v +Tue ${extra_shift} '+%Y-%m-%d')"
    fi
    url="https://TODO-jira-host/issues/?jql=issuetype%20in%20(Ticket%2C%20PDINCIDENT)%20AND%20created%20%3E%3D%20%22${start}%2017%3A30%22%20AND%20created%20%3C%20%22${end}%2017%3A30%22%20AND%20project%20in%20(%22UTS%20-%20Modeling%20Platform%20Infrastructure%22%2C%20%22UTS%20-%20Big%20Data%20Platforms%22%2C%20%22UTS%20-%20Data%20Transfer%20Service%22)%20ORDER%20BY%20created%20DESC"
    open "${url}"
}

ocm() {
    day="$(TZ=Europe/London date +%u)"
    hour="$(TZ=Europe/London date +%H)"
    minute="$(TZ=Europe/London date +%M)"
    if test "${1}" = 'prev'; then
        extra_shift='-v -7d'
    else
        extra_shift=''
    fi
    if test "${day}" -eq 3; then
        if test "${hour}" -lt 17 ; then
            start="$(TZ=Europe/London date -v -7d ${extra_shift} '+%Y-%m-%d')"
            end="$(TZ=Europe/London date ${extra_shift} '+%Y-%m-%d')"
        else
            start="$(TZ=Europe/London date ${extra_shift} '+%Y-%m-%d')"
            end="$(TZ=Europe/London date -v +7d ${extra_shift} '+%Y-%m-%d')"
        fi
    else
        start="$(TZ=Europe/London date -v -Wed ${extra_shift} '+%Y-%m-%d')"
        end="$(TZ=Europe/London date -v +Wed ${extra_shift} '+%Y-%m-%d')"
    fi
    url="https://TODO-jira-host/issues/?jql=issuetype%20in%20(Ticket%2C%20PDINCIDENT)%20AND%20created%20%3E%3D%20%22${start}%2017%3A00%22%20AND%20created%20%3C%20%22${end}%2017%3A00%22%20AND%20project%20in%20(%22UTS%20-%20Modeling%20Platform%20Science%22)%20ORDER%20BY%20created%20DESC"
    open "${url}"
}

pods() {
    component="$1"
    namespace="${2:-dataplayground}"
    if [[ dataplayground =~ ^${namespace} ]]; then
        namespace='dataplayground'
    elif [[ production =~ ^${namespace} ]]; then
        namespace='dataplayground'
    elif [[ staging =~ ^${namespace} ]]; then
        namespace='staging'
    elif [[ test =~ ^${namespace} ]]; then
        namespace='test'
    fi
    if test -z "${component}"; then
        kubectl get pods --namespace "${namespace}"
    else
        kubectl get pods --namespace "${namespace}" --selector "component=${component}"
    fi
}

vault() {
    vtversion="${VT_VERSION:-1.14.9}"
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

# stop exporting stuff
set +a

alias klb='aws --region us-west-2 eks update-kubeconfig --name batch-production-red-usw2 && sed -r -e "s/^([[:space:]]*)command: aws$/\\1command: aws-docker.sh/" -i "" ~/.kube/config'
alias klm='aws --region us-west-2 eks update-kubeconfig --name main-production-red-usw2 && sed -r -e "s/^([[:space:]]*)command: aws$/\\1command: aws-docker.sh/" -i "" ~/.kube/config'

# Miscellany
alias fp='~/src/foss/brendangregg/FlameGraph/stackcollapse-perf.pl | ~/src/foss/brendangregg/FlameGraph/flamegraph.pl'
alias vt='vault login -method ldap -no-store -token-only'
