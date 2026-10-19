#!/usr/bin/env bash

# Standard bash preamble.
#
set -ETeuo pipefail
err_echo() { echo -e "$1" >&2; }
err_exit() { err_echo "$2"; exit $1; }
on_exit() { exit_code=$?; if test ${exit_code} -ne 0; then err_echo '\nFailed'; fi; }
trap on_exit EXIT
