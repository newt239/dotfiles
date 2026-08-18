# CLAUDE.md

コミットメッセージ・コメントの規約は `home/.claude/CLAUDE.md` (グローバル CLAUDE.md) を参照。

## 設定の追加

- 認証情報を含むファイル、および認証情報と同じディレクトリの一括リンクは行わない
- `$HOME` 配下に置くファイルは `home/` に同じ構成で追加する。`home/.mise.toml` の編集は不要
- `$HOME` の外に置くファイルは `home/.mise.toml` の `[dotfiles]` に追加する。`source` は `~/dotfiles/...` の絶対パスで書く
- macOS の設定・パッケージ・フックはすべて `home/.mise.toml` に宣言する。宣言できないものだけ `.bin/*.sh` に置き、bootstrap のフックから呼ぶ
