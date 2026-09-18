test -e ~/.basebashrc && source ~/.basebashrc
test -e ~/.workbashrc && source ~/.workbashrc

export SSH_TAKE_FILES+=" ${HOME}/.bashrc"
export SSH_TAKE_FILES+=" ${HOME}/.ideavimrc"
export SSH_TAKE_FILES+=" ${HOME}/.gitignore"
export SSH_TAKE_FILES+=" ${HOME}/.gitmessage"
export SSH_TAKE_FILES+=" ${HOME}/.gitconfig"

# export functions for use in scripts
set -a

#oce() {
#    day="$(TZ=Europe/London date +%u)"
#    hour="$(TZ=Europe/London date +%H)"
#    if test "${1}" = 'prev'; then
#        extra_shift='-v -7d'
#    else
#        extra_shift=''
#    fi
#    if test "${day}" -eq 2; then
#        if test "${hour}" -lt 14; then
#            start="$(TZ=Europe/London date -v -7d ${extra_shift} '+%Y-%m-%d')"
#            end="$(TZ=Europe/London date ${extra_shift} '+%Y-%m-%d')"
#        else
#            start="$(TZ=Europe/London date ${extra_shift} '+%Y-%m-%d')"
#            end="$(TZ=Europe/London date -v +7d ${extra_shift} '+%Y-%m-%d')"
#        fi
#    else
#        start="$(TZ=Europe/London date -v -Tue ${extra_shift} '+%Y-%m-%d')"
#        end="$(TZ=Europe/London date -v +Tue ${extra_shift} '+%Y-%m-%d')"
#    fi
#    url="https://TODO-jira-host/issues/?jql=issuetype%20%3D%20Ticket%20AND%20created%20%3E%3D%20%22${start}%2014%3A00%22%20AND%20created%20%3C%20%22${end}%2014%3A00%22%20AND%20project%20%3D%20%22UTS%20Bidder%20Services%22%20ORDER%20BY%20created%20DESC"
#    open "${url}"
#}
#
#ocb() {
#    day="$(TZ=Europe/London date +%u)"
#    hour="$(TZ=Europe/London date +%H)"
#    minute="$(TZ=Europe/London date +%M)"
#    if test "${1}" = 'prev'; then
#        extra_shift='-v -7d'
#    else
#        extra_shift=''
#    fi
#    if test "${day}" -eq 2; then
#        if test "${hour}" -lt 17 || (test "${hour}" -eq 17 && test "${minute}" -lt 30) ; then
#            start="$(TZ=Europe/London date -v -7d ${extra_shift} '+%Y-%m-%d')"
#            end="$(TZ=Europe/London date ${extra_shift} '+%Y-%m-%d')"
#        else
#            start="$(TZ=Europe/London date ${extra_shift} '+%Y-%m-%d')"
#            end="$(TZ=Europe/London date -v +7d ${extra_shift} '+%Y-%m-%d')"
#        fi
#    else
#        start="$(TZ=Europe/London date -v -Tue ${extra_shift} '+%Y-%m-%d')"
#        end="$(TZ=Europe/London date -v +Tue ${extra_shift} '+%Y-%m-%d')"
#    fi
#    url="https://TODO-jira-host/issues/?jql=issuetype%20in%20(Ticket%2C%20PDINCIDENT)%20AND%20created%20%3E%3D%20%22${start}%2017%3A30%22%20AND%20created%20%3C%20%22${end}%2017%3A30%22%20AND%20project%20in%20(%22UTS%20-%20Modeling%20Platform%20Infrastructure%22%2C%20%22UTS%20-%20Big%20Data%20Platforms%22%2C%20%22UTS%20-%20Data%20Transfer%20Service%22)%20ORDER%20BY%20created%20DESC"
#    open "${url}"
#}
#
#ocm() {
#    day="$(TZ=Europe/London date +%u)"
#    hour="$(TZ=Europe/London date +%H)"
#    minute="$(TZ=Europe/London date +%M)"
#    if test "${1}" = 'prev'; then
#        extra_shift='-v -7d'
#    else
#        extra_shift=''
#    fi
#    if test "${day}" -eq 3; then
#        if test "${hour}" -lt 17 ; then
#            start="$(TZ=Europe/London date -v -7d ${extra_shift} '+%Y-%m-%d')"
#            end="$(TZ=Europe/London date ${extra_shift} '+%Y-%m-%d')"
#        else
#            start="$(TZ=Europe/London date ${extra_shift} '+%Y-%m-%d')"
#            end="$(TZ=Europe/London date -v +7d ${extra_shift} '+%Y-%m-%d')"
#        fi
#    else
#        start="$(TZ=Europe/London date -v -Wed ${extra_shift} '+%Y-%m-%d')"
#        end="$(TZ=Europe/London date -v +Wed ${extra_shift} '+%Y-%m-%d')"
#    fi
#    url="https://TODO-jira-host/issues/?jql=issuetype%20in%20(Ticket%2C%20PDINCIDENT)%20AND%20created%20%3E%3D%20%22${start}%2017%3A00%22%20AND%20created%20%3C%20%22${end}%2017%3A00%22%20AND%20project%20in%20(%22UTS%20-%20Modeling%20Platform%20Science%22)%20ORDER%20BY%20created%20DESC"
#    open "${url}"
#}
#
#pods() {
#    component="$1"
#    namespace="${2:-dataplayground}"
#    if [[ dataplayground =~ ^${namespace} ]]; then
#        namespace='dataplayground'
#    elif [[ production =~ ^${namespace} ]]; then
#        namespace='dataplayground'
#    elif [[ staging =~ ^${namespace} ]]; then
#        namespace='staging'
#    elif [[ test =~ ^${namespace} ]]; then
#        namespace='test'
#    fi
#    if test -z "${component}"; then
#        kubectl get pods --namespace "${namespace}"
#    else
#        kubectl get pods --namespace "${namespace}" --selector "component=${component}"
#    fi
#}

# stop exporting stuff
set +a

#alias klb='aws --region us-west-2 eks update-kubeconfig --name batch-production-red-usw2 && sed -r -e "s/^([[:space:]]*)command: aws$/\\1command: aws-docker.sh/" -i "" ~/.kube/config'
#alias klm='aws --region us-west-2 eks update-kubeconfig --name main-production-red-usw2 && sed -r -e "s/^([[:space:]]*)command: aws$/\\1command: aws-docker.sh/" -i "" ~/.kube/config'
