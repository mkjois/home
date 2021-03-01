#!/usr/bin/env bash

set -ETeuo pipefail

### ANY PRE-MAIN SETUP GOES HERE

target="${HOME}"

fullname() {
    (cd "$(dirname "$1")" && echo "$(pwd)/$(basename "$1")")
}

### ANY POST-MAIN OR ON-ERROR CLEANUP GOES HERE

on_exit() {
    exit_code=$?
    test ${exit_code} -eq 0 || echo -e '\nFailed' >&2
}

trap on_exit EXIT

### MAIN CODE GOES HERE

find files/ -maxdepth 1 -mindepth 1 | while read thing; do
    b="$(basename "${thing}")"
    f="$(fullname "${thing}")"
    t="${target}/${b}"

    rm -rf "${t}"
    ln -sn "${f}" "${t}"
done
