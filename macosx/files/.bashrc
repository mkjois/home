test -e ~/.basebashrc && source ~/.basebashrc

export JAVA_HOME="$(/usr/libexec/java_home -v 14)"
export GOPATH="${HOME}/src/go"

path="${GOPATH}/bin"
if [[ ! ( ${PATH} =~ (^|:)${path}(:|$) ) ]]; then
    export PATH="${path}:${PATH}"
fi

path="${HOME}/.cargo/bin"
if [[ ! ( ${PATH} =~ (^|:)${path}(:|$) ) ]]; then
    export PATH="${path}:${PATH}"
fi

# iTerm2 integrations
test -e ~/.iterm2_shell_integration.bash && source ~/.iterm2_shell_integration.bash

# Autocompletion
if type brew > /dev/null 2>&1; then

    test -f $(brew --prefix)/etc/bash_completion \
        && source $(brew --prefix)/etc/bash_completion
    test -d $(brew --prefix)/etc/bash_completion.d \
        && source $(brew --prefix)/etc/bash_completion.d/*

    if test -f ~/lib/git-completion.bash; then
        source ~/lib/git-completion.bash
    elif test -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash; then
        source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
    fi
fi

# export functions for use in scripts
set -a

ant() {
    jdkversion="${JDK_VERSION:-8u212}"
    antversion="${ANT_VERSION:-1.9.14}"
    docker run --rm -it \
        -v ${HOME}/.ivy2:/root/.ivy2 \
        -v ${HOME}/.m2:/root/.m2 \
        -v "$(pwd):/src" \
        -w /src \
        --ulimit core=-1 \
        docker-registry.infra.quantcast.com:5000/jdk-${jdkversion}-ant-${antversion} ant "$@"
}

aws() {
    docker run --rm -i \
        -v ${HOME}/.aws:/root/.aws:ro \
        -v ${HOME}/.kube:/root/.kube \
        -v "$(pwd):/aws" \
        amazon/aws-cli "$@"
}

cg() {
    repo="${1:-NONE}"
    matching_dirs="$(find "${GOPATH}/src" -type d -maxdepth 4 -name '\.git' | grep -E "/${repo}[^/]*/\.git\$")"
    if echo -e "${matching_dirs}" | grep -qE '^$'; then
        echo -e "\nNo repos found: ${repo}*\n" >&2
        return 1
    elif test "$(echo -e "${matching_dirs}" | wc -l | awk '{print $1}')" -eq 1; then
        cd "$(dirname "${matching_dirs}")"
    else
        prefix_to_remove="$(echo "${GOPATH}/src/" | sed 's/\//\\\//g')"
        echo -e "\nAmbiguous:\n$(echo -e "${matching_dirs}" | sed 's/\/\.git$//' | sed "s/^${prefix_to_remove}/ - /")\n" >&2
        return 1
    fi
}

dive() {
    docker run --rm -it \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
        wagoodman/dive "$@"
}

draw() {
    encoded="$(cat "$1" | python3 -c 'import sys; import urllib.parse; print(urllib.parse.quote(sys.stdin.read()))')"
    link="https://mermaid-server.eks.qcinternal.io/generate?data=${encoded}"
    echo "${link}"
    open "${link}"
}

#git() {
#    docker run --rm -it \
#        -v ${HOME}/.ssh:/root/.ssh \
#        -v ${HOME}/.gitconfig:/root/.gitconfig \
#        -v ${HOME}/.gitignore:/root/.gitignore:ro \
#        -v ${HOME}/.gitmessage:/root/.gitmessage:ro \
#        -v "$(pwd):/git" \
#        alpine/git "$@"
#}

gitbook() {
    docker run --rm -it \
        -v "$(pwd):/src" \
        -w /src \
        -p 4000:4000 \
        qc/gitbook gitbook "$@"
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

kafka() {
    kfversion="${KF_VERSION:-2.12-2.4.1}"
    docker run --rm -it \
        -v "$(pwd):/src" \
        -w /src \
        wurstmeister/kafka:${kfversion} "$@"
}

newpr() {
    if test "$1"; then
        open "https://github.corp.qc/$(git remote get-url origin | cut -d ':' -f 2 | cut -d '.' -f 1)/compare/$1...$(git branch | grep \* | cut -d ' ' -f 2)"
    else
        open "https://github.corp.qc/$(git remote get-url origin | cut -d ':' -f 2 | cut -d '.' -f 1)/compare/$(git branch | grep \* | cut -d ' ' -f 2)"
    fi
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

oncall() {
    hour="$(TZ=Europe/London date +%H)"
    day="$(TZ=Europe/London date +%u)"
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
    url="https://jira.quantcast.com/issues/?jql=issuetype%20%3D%20Ticket%20AND%20created%20%3E%3D%20%22${start}%2014%3A00%22%20AND%20created%20%3C%20%22${end}%2014%3A00%22%20AND%20project%20%3D%20%22UTS%20Bidder%20Services%22%20ORDER%20BY%20%20created%20DESC"
    open "${url}"
}

packer() {
    pkversion="${PK_VERSION:-1.7.10}"
    docker run --rm -it \
        -v ${HOME}/.aws:/root/.aws:ro \
        -v ${HOME}/.config/packer:/root/.config/packer \
        -v "$(pwd):/src" \
        -w /src \
        hashicorp/packer:${pkversion} "$@"
}

psample() {
    true
    #vault login -method ldap
    #vault read -field pixel-kafka-admin.keystore bds/production/pixel/pixel-events/kafka-admin | sed 's/\x1b\[0*m//g' | base64 -D > pixel-kafka-admin.keystore
    #vault read -field config.properties bds/production/pixel/pixel-events/kafka-admin | sed 's/\x1b\[0*m//g' > config.properties
    #bootstrap='b-4.pixel-events-pixel-pro.vpthu1.c4.kafka.us-west-2.amazonaws.com:9094,b-1.pixel-events-pixel-pro.vpthu1.c4.kafka.us-west-2.amazonaws.com:9094,b-5.pixel-events-pixel-pro.vpthu1.c4.kafka.us-west-2.amazonaws.com:9094'
    #protobufs="${HOME}/src/qc/REALTIME-protobuf"
    #num_samples=1
    #docker run --rm -i -v "$(pwd):/src:ro" -w /src confluentinc/cp-kafkacat kafkacat -C -F config.properties -b "${bootstrap}" -t pixel-events -o end -D '' -c "${num_samples}" | protoc --decode Pixel --proto_path "${protobufs}/src/main/proto" --proto_path "${protobufs}/src/main/proto3" "${protobufs}/src/main/proto/pixel-entry.proto"
}

pssh() {
    docker run --rm -i \
        -v ${HOME}/.ssh:/root/.ssh:ro \
        -v "$(pwd):/src" \
        -w /src \
        reactivehub/pssh parallel-ssh -l ${USER} -o PermitLocalCommand=no "$@"
}

terraform() {
    tfversion="${TF_VERSION:-1.0.5}"
    docker run --rm -i \
        -v ${HOME}/.aws:/root/.aws:ro \
        -v ${HOME}/.ssh:/root/.ssh:ro \
        -v ${HOME}/.terraform.d:/root/.terraform.d \
        -v "$(pwd):/src" \
        -w /src \
        hashicorp/terraform:${tfversion} "$@"
}

vault() {
    vtversion="${VT_VERSION:-1.8.2}"
    address="${VAULT_ADDR:-https://vault.int.quantcast.com:8200}"
    docker run --rm -it \
        --entrypoint '' \
        -e "USER=${USER}" \
        -e "VAULT_ADDR=${address}" \
        -v "$(pwd):/src" \
        -v ${HOME}/.vault-root:/root \
        -w /src \
        vault:${vtversion} vault "$@"
}

yarn() {
    nodeversion="${NODE_VERSION:-14}"
    docker run --rm -it \
        -v ${HOME}/.ssh:/root/.ssh:ro \
        -v "$(pwd):/src" \
        -w /src \
        -p 3000:3000 \
        node:${nodeversion}-alpine yarn "$@"
}

# stop exporting stuff
set +a

alias alpp='docker run --rm -it -v ${HOME}/.aws:/root/.aws docker-registry.infra.quantcast.com:5000/qc/aws-tools ./qc_aws_login.py -u ${USER} -d 43200 --factor push platform     --role rtb-platform'
alias alpd='docker run --rm -it -v ${HOME}/.aws:/root/.aws docker-registry.infra.quantcast.com:5000/qc/aws-tools ./qc_aws_login.py -u ${USER} -d 43200 --factor push platform-dev --role rtb-platform-dev'
alias cti='ant clean test integ-test'
alias djj='ant deploy-job.jar -Ddeploy.host=launch0'
alias fp='~/src/foss/brendangregg/FlameGraph/stackcollapse-perf.pl | ~/src/foss/brendangregg/FlameGraph/flamegraph.pl'
alias gp='gpg --sign -u "${EMAIL}" -o /dev/null ~/.gitmessage'
alias upcask="brew upgrade --cask \$(brew list --cask -1 --full-name | sort | tr '\n' ' ')"
alias vt='vault login -method ldap -no-store -token-only'
