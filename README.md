# Open with Default App

VS Code のエクスプローラーでファイルをクリックしたとき、設定した拡張子に一致する場合は
VS Code のエディタで開かずに OS のデフォルトアプリで開きます。

## 動作の仕組み

`onDidChangeActiveTextEditor` イベントを使い、エディタが開いた直後に拡張子を判定します。
対象拡張子に一致した場合、エディタを即座に閉じて OS のデフォルトアプリを起動します。

| OS      | 使用コマンド            |
|---------|------------------------|
| Windows | `cmd /c start "" <file>` |
| macOS   | `open <file>`           |
| Linux   | `xdg-open <file>`       |

## 設定

`settings.json` または VS Code の設定UIから変更できます。

### `openWithDefaultApp.extensions`

OS のデフォルトアプリで開く拡張子のリスト。デフォルト:

```json
[
  ".xlsx", ".xls", ".xlsm",
  ".docx", ".doc",
  ".pptx", ".ppt",
  ".pdf",
  ".zip", ".tar", ".gz", ".7z", ".rar",
  ".exe", ".msi", ".dmg", ".pkg",
  ".mp3", ".mp4", ".avi", ".mov", ".mkv", ".wav", ".flac",
  ".png", ".jpg", ".jpeg", ".gif", ".bmp", ".tiff",
  ".psd", ".ai", ".sketch"
]
```

カスタマイズ例:

```json
"openWithDefaultApp.extensions": [".xlsx", ".pdf", ".mp4"]
```

### `openWithDefaultApp.showNotification`

ファイルをデフォルトアプリで開いたときに通知を表示するか。デフォルト: `true`

```json
"openWithDefaultApp.showNotification": false
```

---

## ビルド & インストール手順

### 前提

- [Node.js](https://nodejs.org) (v18 以上推奨)

### ビルド

```powershell
# PowerShell でビルドスクリプトを実行
.\build.ps1
```

または手動で:

```bash
npm install
npm run compile
npm run package
```

### インストール

生成された `.vsix` ファイルを VS Code にインストール:

```bash
code --install-extension open-with-default-app-0.0.1.vsix
```

または VS Code の `Ctrl+Shift+P` → `Extensions: Install from VSIX...` から選択。
