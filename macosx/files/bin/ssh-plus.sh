#!/usr/bin/env bash

set -ETeuo pipefail
err_exit() { echo -e "$2" >&2; exit $1; }
on_exit() { exit_code=$?; if test ${exit_code} -ne 0; then echo -e '\nFailed' >&2; fi; }
trap on_exit EXIT

host="${1}"

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

local_command="rsync -aLKzv \
    -e 'ssh -S none' \
    ${SSH_TAKE_FILES} %n:~/"

exec ssh \
    -o "LocalCommand=${local_command}" \
    -o 'PermitLocalCommand=yes' \
    "${host}"

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
    "${host}"
