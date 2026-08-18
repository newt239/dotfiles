# CLAUDE.md

コミットメッセージ・コメントの規約はグローバル CLAUDE.md である `home/.claude/CLAUDE.md` を参照。

## ドキュメント

- 簡潔に書く
- 文章中に括弧書きで説明を挟まない

## 設定の追加

- 認証情報を含むファイル、および認証情報と同じディレクトリの一括リンクは行わない
- `$HOME` 配下に置くファイルは `home/` に同じ構成で追加する。`home/.mise.toml` の編集は不要
- `$HOME` の外に置くファイルは `home/.mise.toml` の `[dotfiles]` に追加する。`source` は `~/dotfiles/...` の絶対パスで書く
- macOS の設定・パッケージ・フックはすべて `home/.mise.toml` に宣言する。宣言できないものだけ `.bin/*.sh` に置き、bootstrap のフックから呼ぶ
- リポジトリ直下の `mise.toml` はこのリポジトリ自体の開発用。`$HOME` に配る設定を書かない
- マシンごとに変えたい git 設定は `~/.gitconfig.local` に置く。`home/.gitconfig` が末尾で include している
- `home/.mise.toml` は業務でも使う最小構成にする。私用マシンにだけ入れるものは `home/.mise.personal.toml` と `.bin/Brewfile.personal` に置く
- `[bootstrap.hooks]` は env をまたいで追記される。上書きはできない
