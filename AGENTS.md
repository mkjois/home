# Editing configuration

`base/files/.basevimrc` is shared by `base/files/.vimrc` and the macOS Vim symlinks.
`macosx/files/vscode/settings-user.json` is the VS Code user configuration installed by `macosx/install.sh`.

When changing a Vim setting or mapping in `.basevimrc` or `.vimrc`, check the VS Code file for the corresponding behavior. When changing the VS Code file, check both Vim files. Update both where the behavior is supported, and briefly note any intentional difference. Keep existing unrelated settings intact.
