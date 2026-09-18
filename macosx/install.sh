#!/usr/bin/env bash

# Standard bash preamble.
#
set -ETeuo pipefail
err_echo() { echo -e "$1" >&2; }
err_exit() { err_echo "$2"; exit $1; }
on_exit() { exit_code=$?; if test ${exit_code} -ne 0; then echo -e '\nFailed' >&2; fi; }
trap on_exit EXIT

target="${HOME}"

fullname() {
    (cd "$(dirname "$1")" && echo "$(pwd)/$(basename "$1")")
}

# TODO: maybe get this working nicely...
err_exit 1 "405: script not implemented yet..."

find files/ -maxdepth 1 -mindepth 1 | while read thing; do
    b="$(basename "${thing}")"
    f="$(fullname "${thing}")"
    t="${target}/${b}"

    rm -rf "${t}"
    ln -sn "${f}" "${t}"
done
