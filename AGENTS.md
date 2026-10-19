# Editing configuration

`base/files/.basevimrc` is shared by multiple other `vimrc` files.
`base/files/vscode/settings-user.json` and `keybindings-user.json` are the VS Code user configuration installed by `macOS/install.sh`.
The local `extension-panel-position` supplies the `g Space` panel-position toggle.

When changing a Vim setting or mapping in `.basevimrc` or `.vimrc`, check the VS Code file for the corresponding behavior.
When changing the VS Code file, check both Vim files. Update both where the behavior is supported,
and briefly note any intentional difference. Keep existing unrelated settings intact.
