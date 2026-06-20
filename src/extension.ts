import * as vscode from 'vscode';
import * as cp from 'child_process';
import * as path from 'path';
import * as fs from 'fs';

/**
 * カスタムエディタープロバイダー。
 * ファイルクリック時に resolveCustomEditor() が呼ばれる。
 */
class DefaultAppEditorProvider implements vscode.CustomReadonlyEditorProvider 
{
  public static readonly viewType = 'openWithDefaultApp.editor';

  // VS Code がファイルのデータモデルを要求したときに呼ばれる（必須実装）
  openCustomDocument(uri: vscode.Uri): vscode.CustomDocument 
  {
    return { uri, dispose: () => {} };
  }

  // ファイルクリック時のイベントハンドラ本体
  resolveCustomEditor( document: vscode.CustomDocument, _webviewPanel: vscode.WebviewPanel, ): void 
  {
    const filePath = document.uri.fsPath;
    const ext = path.extname(filePath).toLowerCase();

    // 設定から対象拡張子リストを取得
    const config = vscode.workspace.getConfiguration('openWithDefaultApp');
    const extensions: string[] = config.get('extensions') ?? [];

    const targetExtensions = new Set(
      extensions.map((e) => e.toLowerCase().startsWith('.') ? e.toLowerCase() : '.' + e.toLowerCase())
    );

    // 拡張子が登録されていない場合
    if (!targetExtensions.has(ext)) 
    {
      // タブを即閉じ
      setTimeout(() => {
            vscode.commands.executeCommand('workbench.action.closeActiveEditor');
            vscode.commands.executeCommand('vscode.openWith', document.uri, 'default');
          }, 0);  // ← 100 → 50 に短縮
      return;
    }

    // 対象拡張子 → explorer.exe で投げる
    vscode.window.showInformationMessage(`${ext} をエクスプローラで開きます`);
    cp.spawn('explorer.exe', [filePath], { detached: true, stdio: 'ignore' }).unref();

    // タブを閉じる
    setTimeout(() => {
      vscode.commands.executeCommand('workbench.action.closeActiveEditor');
    }, 10);  // ← これも 50 に短縮  }
  }
}

// 拡張機能起動時のエントリポイント
export function activate(context: vscode.ExtensionContext): void 
{
  // カスタムエディタープロバイダーを登録する（イベントハンドラの登録に相当）
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
