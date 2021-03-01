#!/usr/bin/env bash

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

false
