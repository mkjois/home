#!/usr/bin/env bash

# Standard bash preamble.
#
set -ETeuo pipefail
err_echo() { echo -e "$1" >&2; }
err_exit() { err_echo "$2"; exit $1; }
on_exit() { exit_code=$?; if test ${exit_code} -ne 0; then err_echo '\nFailed'; fi; }
trap on_exit EXIT


########################################################################
##                                                                    ##
## FROM LOCAL                                                         ##
##                                                                    ##
## In theory should be more straightforward,                          ##
## although becomes more complicated                                  ##
## with use of ControlMaster sockets.                                 ##
##                                                                    ##
## If this isn't syncing files and it's unclear why,                  ##
## try deleting the ControlMaster socket if you have that configured. ##
##                                                                    ##
## TODO: use cache tags to run local command conditionally,           ##
## assuming use of sockets doesn't solve that already.                ##
##                                                                    ##
########################################################################

#fqdn="$(ssh -G "${host}" | grep -E '^hostname ' | cut -d ' ' -f 2)"
#ip="$(host "${fqdn}" | cut -d ' ' -f 4)"

rm -rf /tmp/.ssh
mkdir -p /tmp/.ssh
cp "${HOME}/.ssh/id_ed25519.pub" /tmp/.ssh/authorized_keys

if ! ssh-add -l | awk '{print $3}' | grep -qE "^${HOME}/\\.ssh/id_ed25519\$" && ! ssh-add -l | awk '{print $4}' | grep -qE "^\(ED25519\)\$" ; then
    err_echo "Adding SSH pubkey to agent..."
    ssh-add -t 86400 "${HOME}/.ssh/id_ed25519"
fi

gpg -a --export > "${HOME}/.ssh/pubring.gpg.txt"

local_command="rsync -aLKzv \
    -e 'ssh -S none' \
    ${SSH_TAKE_FILES} \
    ${HOME}/.ssh/pubring.gpg.txt \
    %r@%n:~/"

exec ssh \
    -t \
    -o "LocalCommand=${local_command}" \
    -o 'PermitLocalCommand=yes' \
    "$@"

exit


########################################################################
##                                                                    ##
## FROM REMOTE                                                        ##
##                                                                    ##
## Seems more reliable, but also makes more assumptions,              ##
## and is thus more complicated.                                      ##
##                                                                    ##
## If password seems required and it's unclear why,                   ##
## try deleting the ControlMaster socket if you have that configured. ##
##                                                                    ##
## TODO: this wasn't working as intended last time I tested...        ##
##                                                                    ##
########################################################################

identity_persistence_time_sec="$((20 + 2 * $(echo "${SSH_TAKE_FILES}" | tr ' ' '\n' | wc -l)))"
file_list="$(echo "${SSH_TAKE_FILES}" | sed 's/ / :/g')"

remote_command="rsync -aLKzv \
    -e 'ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' \
    \$(echo \${SSH_CLIENT} | cut -d ' ' -f 1):${file_list} \${HOME}/ \
    && \${SHELL}"

rm -f "${HOME}/.ssh/authorized_keys"
ln -s id_rsa.pub "${HOME}/.ssh/authorized_keys"
ssh-add -t "${identity_persistence_time_sec}" "${HOME}/.ssh/id_rsa"

exec ssh -At \
    -o "RemoteCommand=${remote_command}" \
    "$@"
