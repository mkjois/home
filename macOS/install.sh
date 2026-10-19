#!/usr/bin/env bash

# Standard bash preamble.
#
set -ETeuo pipefail
err_echo() { echo -e "$1" >&2; }
err_exit() { err_echo "$2"; exit $1; }
on_exit() { exit_code=$?; if test ${exit_code} -ne 0; then echo -e '\nFailed' >&2; fi; }
trap on_exit EXIT

#target="${HOME}"
#
#fullname() {
#    (cd "$(dirname "$1")" && echo "$(pwd)/$(basename "$1")")
#}
#
#find files/ -maxdepth 1 -mindepth 1 | while read thing; do
#    b="$(basename "${thing}")"
#    f="$(fullname "${thing}")"
#    t="${target}/${b}"
#
#    rm -rf "${t}"
#    ln -sn "${f}" "${t}"
#done

DOTFILES_PATH="$(realpath "$(dirname "$0")/..")"

mkdir -p "${HOME}/.config/ai" "${HOME}/.codex" "${HOME}/.claude"
ln -sfn "${DOTFILES_PATH}/base/files/AGENTS.ref.md" "${HOME}/.config/ai/AGENTS.md"
ln -sfn "${DOTFILES_PATH}/base/files/CLAUDE.ref.md" "${HOME}/.claude/CLAUDE.md"
ln -sfn "${HOME}/.config/ai/AGENTS.md"              "${HOME}/.codex/AGENTS.md"

ln -sf "${DOTFILES_PATH}/macOS/files/.basebashrc"   "${HOME}/.basebashrc"
ln -sf "${DOTFILES_PATH}/macOS/files/.bashrc"       "${HOME}/.bashrc"
ln -sf "${DOTFILES_PATH}/macOS/files/.bash_profile" "${HOME}/.bash_profile"
ln -sf "${DOTFILES_PATH}/macOS/files/.profile"      "${HOME}/.profile"

ln -sf "${DOTFILES_PATH}/base/files/.basevimrc" "${HOME}/.basevimrc"
ln -sf "${DOTFILES_PATH}/base/files/.ideavimrc" "${HOME}/.ideavimrc"
ln -sf "${DOTFILES_PATH}/base/files/.vimrc"     "${HOME}/.vimrc"

mkdir -p "${HOME}/Library/Application Support/Code/User"
ln -sf  "${DOTFILES_PATH}/base/files/vscode/settings-user.json"    "${HOME}/Library/Application Support/Code/User/settings.json"
ln -sf  "${DOTFILES_PATH}/base/files/vscode/keybindings-user.json" "${HOME}/Library/Application Support/Code/User/keybindings.json"
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

mkdir -p "${HOME}/.vscode/extensions"
panel_position_extension="${DOTFILES_PATH}/base/files/vscode/extension-panel-position"
panel_position_version="$(jq -er '.version' "${panel_position_extension}/package.json")"
panel_position_link="${HOME}/.vscode/extensions/mkjois:home:panel-position:${panel_position_version}"
for panel_position_old_link in "${HOME}/.vscode/extensions/mkjois:home:panel-position"*; do
    if [[ -L "${panel_position_old_link}" && "${panel_position_old_link}" != "${panel_position_link}" &&
          "$(readlink "${panel_position_old_link}")" == "${panel_position_extension}" ]]; then
        unlink "${panel_position_old_link}"
    fi
done
ln -sfn "${panel_position_extension}" "${panel_position_link}"

ln -sf "${DOTFILES_PATH}/base/files/git/gitignore"  "${HOME}/.gitignore"
ln -sf "${DOTFILES_PATH}/base/files/git/gitmessage" "${HOME}/.gitmessage"
cp -f  "${DOTFILES_PATH}/base/files/git/gitconfig"  "${HOME}/.gitconfig"

mkdir -p "${HOME}/.ssh/config.d"
mkdir -p "${HOME}/.ssh/s" # sockets (104-char absolute path length limit)
ln -sf "${DOTFILES_PATH}/base/files/.ssh/config" "${HOME}/.ssh/config"

#git config set --global user.email "${EMAIL:-"3893724+mkjois@users.noreply.github.com"}" 2> /dev/null \
#    || git config --global user.email "${EMAIL:-"3893724+mkjois@users.noreply.github.com"}"
#git config set --global alias.co 'commit' 2> /dev/null \
#    || git config --global alias.co 'commit'
#git config unset --global user.signingkey 2> /dev/null \
#    || git config --global --unset user.signingkey
#git config unset --global commit.gpgsign 2> /dev/null \
#    || git config --global --unset commit.gpgsign
#git config unset --global tag.gpgsign 2> /dev/null \
#    || git config --global --unset tag.gpgsign

rm -rf "${HOME}/.vim"
rm -rf "${HOME}/bin"
rm -rf "${HOME}/lib"
ln -sf "${DOTFILES_PATH}/base/files/.vim" "${HOME}/.vim"
ln -sf "${DOTFILES_PATH}/base/files/bin" "${HOME}/bin"
ln -sf "${DOTFILES_PATH}/base/files/lib" "${HOME}/lib"

pushd "${DOTFILES_PATH}" > /dev/null
git submodule update --recursive --init
popd > /dev/null
