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
    if test ${exit_code} -eq 0; then
        true
    else
        echo -e '\nFailed' >&2
    fi
}

trap on_exit EXIT

### MAIN CODE GOES HERE

if test "${PACKAGES}"; then
    apt update
    apt install -y --no-install-recommends ${PACKAGES}
fi

if test -f /deps/requirements.txt; then
    pip install --no-cache-dir --upgrade pip
    pip install --no-cache-dir -r /deps/requirements.txt

    if test -f /deps/requirements-test.txt; then
        pip install --no-cache-dir -r /deps/requirements-test.txt
    fi
fi

exec "$@"
