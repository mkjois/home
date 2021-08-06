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
    version="${1:-11}"
    export JAVA_HOME="$(/usr/libexec/java_home -v "$(test "${version}" -lt 9 && echo "1.${version}" || echo "${version}")")"
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

packer() {
    pkversion="${PK_VERSION:-1.7.3}"
    docker run --rm -it \
        -v ${HOME}/.aws:/root/.aws:ro \
        -v "$(pwd):/src" \
        -w /src \
        hashicorp/packer:${pkversion} "$@"
}

pssh() {
    docker run --rm -i \
        -v ~/.ssh:/root/.ssh:ro \
        -v "$(pwd):/src" \
        -w /src \
        reactivehub/pssh parallel-ssh -l ${USER} "$@"
}

terraform() {
    tfversion="${TF_VERSION:-1.0.1}"
    docker run --rm -i \
        -v ${HOME}/.aws:/root/.aws:ro \
        -v ${HOME}/.ssh:/root/.ssh:ro \
        -v ${HOME}/.terraform.d:/root/.terraform.d \
        -v "$(pwd):/src" \
        -w /src \
        hashicorp/terraform:${tfversion} "$@"
}

vault() {
    vtversion="${VT_VERSION:-1.7.3}"
    docker run --rm -it \
        --entrypoint '' \
        -e USER=${USER} \
        -e VAULT_ADDR=https://vault.int.quantcast.com:8200 \
        -v "$(pwd):/src" \
        -w /src \
        vault:${vtversion} ash
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
