#!/usr/bin/env bash

set -ETeuo pipefail

### ANY PRE-MAIN SETUP GOES HERE

true

### ANY POST-MAIN OR ON-ERROR CLEANUP GOES HERE

on_exit() {
    exit_code=$?
    test ${exit_code} -eq 0 && echo -e '\nSuccess' >&2 || echo -e '\nFailed' >&2
}

trap on_exit EXIT

### MAIN CODE GOES HERE

echo -e '\nAvailable setups:'
for d in $(find . -type d -depth 1 | grep -Ev '\.git$' | sed 's/^\.\///g'); do
    echo "- ${d}"
done

echo
read -p 'Choose a setup: ' choice
test -d "${choice}" || (echo -e "\nInvalid setup: ${choice}" && exit 1)

pushd "${choice}" > /dev/null
./install.sh
popd > /dev/null
