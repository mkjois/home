#!/usr/bin/env bash

set -ETeuo pipefail
err_exit() { echo -e "$2" >&2; exit $1; }
on_exit() { exit_code=$?; if test ${exit_code} -ne 0; then echo -e '\nFailed' >&2; fi; }
trap on_exit EXIT
