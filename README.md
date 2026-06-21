# Open with Default App

ファイルをクリックすると、OS のデフォルトアプリケーションで自動的に開く VS Code 拡張機能です。Windows 専用。

---

## ✨ 何ができる？

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

## 🔧 トラブルシューティング

### Q1: ファイルがクリックしても何も起きない

**原因**: 設定に拡張子が含まれていない

**解決策**:
1. `Ctrl + Shift + P` → ユーザー設定を開く
2. `openWithDefaultApp.extensions` に拡張子を追加
3. VS Code を再起動

```json
{
  "openWithDefaultApp.extensions": [".xlsx"]  // ← 拡張子を追加
}
```

---

### Q2: 一瞬タブが開いて閉じる

**原因**: 設定に拡張子がない場合の正常な動作です

**説明**: 
```
ファイルをクリック
  ↓
VS Code のタブが開く（一瞬）
  ↓
拡張子をチェック
  ↓
対象外なら → タブを閉じて通常エディタで開く
対象なら   → タブを閉じてデフォルトアプリで開く
```

この動作は正常です。タブに含めたい拡張子を設定に追加してください。

---

### Q3: ファイルが VS Code で開いてしまう

**原因1**: 設定に拡張子が含まれていない

```json
// ❌ これだと .docx が対象外
{
  "openWithDefaultApp.extensions": [".xlsx", ".pdf"]
}

// ✅ .docx を追加
{
  "openWithDefaultApp.extensions": [".xlsx", ".pdf", ".docx"]
}
```

**原因2**: ドット（.）の記号が異なる

```json
// ❌ ドットなし
{
  "openWithDefaultApp.extensions": ["xlsx"]
}

// ✅ ドット付き
{
  "openWithDefaultApp.extensions": [".xlsx"]
}
```

拡張機能が自動で修正するので、どちらでも大丈夫です。

---

### Q4: 動作をデバッグしたい

ログファイルを確認：

**Windows:**
```
C:\Users\[ユーザー名]\AppData\Local\Temp\vscode-extension.log
```

ログ内容の例：
```
[2026-06-21T16:26:50.061Z] ファイル: c:\Users\shu\Desktop\document.docx | 拡張子: .docx | 設定: [".xlsx",".pdf"] | マッチ: false
```

この例では、`.docx` は設定に含まれていないため `マッチ: false` になっています。

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

## 📄 ライセンス

MIT License

---

## 🤝 フィードバック

不具合や機能リクエストは GitHub Issues でお願いします：

https://github.com/local/open-with-default-app

---

## 💡 よくある使い方

### Excel ファイルを素早く確認

```
プロジェクト内の .xlsx をクリック
  ↓
Excel で即座に内容確認
  ↓
確認後、メールで送信
```

VS Code での編集は不要な場合に便利！

### 動画ファイルをプレビュー

```
assets/ フォルダの .mp4 をクリック
  ↓
メディアプレイヤーで再生
  ↓
VS Code に戻ってコードを編集
```

両方のツールをシームレスに行き来できます。

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

**楽しい開発を！** 🚀
