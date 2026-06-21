# Open with Default App

ファイルをクリックすると、OS のデフォルトアプリケーションで自動的に開く VS Code 拡張機能です。Windows 専用。

---

## 目次

- [概要](#-概要)
- [システム要件](#️-システム要件)
- [インストール](#-インストール)
- [使い方](#-使い方)
- [設定方法](#️-設定方法)
- [対応している拡張子（デフォルト）](#-対応している拡張子デフォルト)
- [ワークスペース別の設定](#-ワークスペース別の設定)
- [ライセンス](#-ライセンス)
- [フィードバック](#-フィードバック)

---

## ✨ 概要

```
VS Code 内でファイルをクリック
    ↓
設定した拡張子なら...
    ↓
Excel → Excel で開く
PDF   → PDF ビューアで開く
動画  → Windows メディアプレイヤーで開く
```

対象外の拡張子は通常通り VS Code で開きます。

---

## 📥 インストール

### 方法1: VSIX ファイルからインストール（推奨）

1. **拡張機能ファイルを取得**
   - `open-with-default-app-X.X.X.vsix` をダウンロード

2. **VS Code で開く**
   - `Ctrl + Shift + P` → `Extensions: Install from VSIX...` を入力
   - ファイルを選択

3. **再起動**
   - VS Code を再起動

### 方法2: コマンドラインからインストール

```bash
code --install-extension open-with-default-app-X.X.X.vsix
```

---

## 🎯 使い方

### 基本的な使い方

1. **VS Code で対象ファイルをクリック**
   ```
   ファイルエクスプローラ
   ├─ document.xlsx    ← クリック
   ├─ report.pdf       ← クリック
   └─ video.mp4        ← クリック
   ```

2. **デフォルトアプリで自動的に開く**
   ```
   document.xlsx → Excel が起動
   report.pdf    → PDF ビューアが起動
   video.mp4     → メディアプレイヤーが起動
   ```

---

## ⚙️ 設定方法

### 対象の拡張子を指定

1. **VS Code で設定を開く**
   ```
   Ctrl + Shift + P → "ユーザー設定を開く (JSON)" を入力
   ```

2. **以下を追加**
   ```json
   {
     "openWithDefaultApp.extensions": [
       ".xlsx", ".xls", ".xlsm",
       ".docx", ".doc",
       ".pptx", ".ppt",
       ".pdf",
       ".zip", ".tar", ".gz", ".7z", ".rar",
       ".exe", ".msi",
       ".mp3", ".mp4", ".avi", ".mov", ".mkv", ".wav", ".flac",
       ".psd", ".ai", ".sketch"
     ]
   }
   ```

3. **カスタマイズ例**

   **Excel ファイルだけ開きたい**
   ```json
   {
     "openWithDefaultApp.extensions": [".xlsx", ".xls", ".xlsm"]
   }
   ```

   **動画ファイルを追加したい**
   ```json
   {
     "openWithDefaultApp.extensions": [
       ".mp4", ".avi", ".mov", ".mkv",
       ".webm", ".flv"
     ]
   }
   ```

### 通知の設定

ファイルを開いた時の通知を非表示にしたい：

```json
{
  "openWithDefaultApp.showNotification": false
}
```

---

## 📋 対応している拡張子（デフォルト）

| カテゴリ | 拡張子 |
|---------|--------|
| **Office** | .xlsx, .xls, .xlsm, .docx, .doc, .pptx, .ppt |
| **ドキュメント** | .pdf |
| **圧縮** | .zip, .tar, .gz, .7z, .rar |
| **実行ファイル** | .exe, .msi |
| **メディア** | .mp3, .mp4, .avi, .mov, .mkv, .wav, .flac |
| **デザイン** | .psd, .ai, .sketch |

もちろん他の拡張子も設定に追加できます！

---

## 🖥️ システム要件

- **OS**: Windows のみ
- **VS Code**: 1.85.0 以上

---
## 🎓 ワークスペース別の設定

プロジェクトごとに設定を変えたい場合：

`.vscode/settings.json` をプロジェクトフォルダに作成：

```json
{
  "openWithDefaultApp.extensions": [".pdf", ".mp4"]
}
```

このプロジェクトだけ `.pdf` と `.mp4` が対象になります。

---

## 📄 ライセンス

MIT License

---

## 🤝 フィードバック

不具合や機能リクエストは GitHub Issues でお願いします：

https://github.com/pumila99/vscodeOpenlink/issues

---
