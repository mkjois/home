#!/bin/bash

set -ETeuo pipefail

### ANY PRE-MAIN SETUP GOES HERE

true

### ANY POST-MAIN OR ON-ERROR CLEANUP GOES HERE

err_exit() {
    echo -e "$2" >&2
    exit $1
}

on_exit() {
    exit_code=$?
    if test ${exit_code} -eq 0 ; then
        true
    else
        echo -e '\nFailed' >&2
    fi
}

trap on_exit EXIT

### MAIN CODE GOES HERE

if test "${PACKAGES}" ; then
    apt update
    apt install -y --no-install-recommends ${PACKAGES}
fi

pip install --upgrade pip
pip install black 'black[jupyter]'

if test -f /deps/requirements.txt ; then
    pip install -r /deps/requirements.txt

    if test -f /deps/requirements-test.txt ; then
        pip install -r /deps/requirements-test.txt
    fi
fi

if find . -type f -name pyproject.toml ! -path './.git/*' | grep -q . ; then
    curl -sSL https://install.python-poetry.org | python3 -
    export PATH="${HOME}/.local/bin:$PATH"
    apt update
    apt install -y --no-install-recommends bash-completion
    poetry completions bash >> ~/.bash_completion
fi

if test -f ./tasks.py ; then
    pip install invoke
fi

exec "$@"
