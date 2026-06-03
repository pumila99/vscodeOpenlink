import * as vscode from 'vscode';
import * as cp from 'child_process';
import * as path from 'path';

/**
 * ファイルをOSのデフォルトアプリで開く
 */
function openWithDefaultApp(filePath: string): void {
  const platform = process.platform;
  if (platform === 'win32') {
    cp.spawn('cmd', ['/c', 'start', '', filePath], {
      detached: true,
      stdio: 'ignore',
    }).unref();
  } else if (platform === 'darwin') {
    cp.spawn('open', [filePath], { detached: true, stdio: 'ignore' }).unref();
  } else {
    cp.spawn('xdg-open', [filePath], { detached: true, stdio: 'ignore' }).unref();
  }
}

/**
 * 何も表示しないカスタムエディター
 */
class DefaultAppEditorProvider implements vscode.CustomReadonlyEditorProvider {
  public static readonly viewType = 'openWithDefaultApp.editor';

  openCustomDocument(uri: vscode.Uri): vscode.CustomDocument {
    return { uri, dispose: () => {} };
  }

  resolveCustomEditor(
    document: vscode.CustomDocument,
    webviewPanel: vscode.WebviewPanel,
  ): void {
    const filePath = document.uri.fsPath;
    const fileName = path.basename(filePath);

    // 最小限のHTMLを設定
    webviewPanel.webview.html = `<!DOCTYPE html>
<html><body style="background:#1e1e1e;color:#888;font-family:sans-serif;padding:20px;">
<p>Opening ${fileName} with default application...</p>
</body></html>`;

    // OSで開く
    openWithDefaultApp(filePath);

    // dispose()は呼ばずにコマンドでタブを閉じる
    // setTimeoutで次のイベントループに回すことでWebview初期化完了後に閉じる
    setTimeout(() => {
      vscode.commands.executeCommand('workbench.action.closeActiveEditor');

      const config = vscode.workspace.getConfiguration('openWithDefaultApp');
      const showNotification: boolean = config.get('showNotification') ?? true;
      if (showNotification) {
        vscode.window.showInformationMessage(
          `Opened with default app: ${fileName}`
        );
      }
    }, 100);
  }
}

export function activate(context: vscode.ExtensionContext): void {
  console.log('open-with-default-app: activated');

  const provider = new DefaultAppEditorProvider();

  const registration = vscode.window.registerCustomEditorProvider(
    DefaultAppEditorProvider.viewType,
    provider,
    {
      supportsMultipleEditorsPerDocument: false,
      webviewOptions: { retainContextWhenHidden: false },
    }
  );

  context.subscriptions.push(registration);
}

export function deactivate(): void {}
