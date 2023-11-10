#!/bin/ash

set -euo pipefail

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
    apk update
    apk add ${PACKAGES}
fi

pip install --upgrade pip
pip install black 'black[jupyter]'

if test -f /deps/requirements.txt ; then
    pip install -r /deps/requirements.txt

    if test -f /deps/requirements-test.txt ; then
        pip install -r /deps/requirements-test.txt
    fi
fi

exec "$@"
