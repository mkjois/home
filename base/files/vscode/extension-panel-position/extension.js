const vscode = require('vscode');

function activate(context) {
    context.subscriptions.push(vscode.commands.registerCommand('mkjois/home/panel-position/toggle', async () => {
        // VS Code does not expose the panel position to extensions. Remember the
        // position set by this command; on first use, move the panel right.
        const lastPosition = context.workspaceState.get('panelPosition', 'bottom');
        const nextPosition = lastPosition === 'right' ? 'bottom' : 'right';
        const command = nextPosition === 'right'
            ? 'workbench.action.positionPanelRight'
            : 'workbench.action.positionPanelBottom';

        await vscode.commands.executeCommand(command);
        await context.workspaceState.update('panelPosition', nextPosition);
    }));
}

module.exports = { activate };
