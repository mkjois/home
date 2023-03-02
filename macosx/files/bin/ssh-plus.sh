#!/usr/bin/env bash

set -ETeuo pipefail
err_exit() { echo -e "$2" >&2; exit $1; }
on_exit() { exit_code=$?; if test ${exit_code} -ne 0; then echo -e '\nFailed' >&2; fi; }
trap on_exit EXIT

host="${1}"

identity_persistence_time_sec="$((20 + 2 * $(echo "${SSH_TAKE_FILES}" | tr ' ' '\n' | wc -l)))"
file_list="$(echo "${SSH_TAKE_FILES}" | sed 's/ / :/g')"

remote_command="rsync -aLKzv \
    -e 'ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' \
    \$(echo \${SSH_CLIENT} | cut -d ' ' -f 1):${file_list} \${HOME}/ \
    && \${SHELL}"

rm -f "${HOME}/.ssh/authorized_keys"
ln -s id_rsa.pub "${HOME}/.ssh/authorized_keys"
ssh-add -t "${identity_persistence_time_sec}" "${HOME}/.ssh/id_rsa"

# If password seems required and unclear why,
# try deleting the ControlMaster socket.
exec ssh -A \
    -o "RemoteCommand=${remote_command}" \
    -o 'RequestTTY=force' \
    "${host}"
