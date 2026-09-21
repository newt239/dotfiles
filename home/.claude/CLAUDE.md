# CLAUDE.md

## コミットメッセージ

- 1 行以内で書く。本文は付けない
- Conventional Commits の prefix (`feat:` / `fix:` / `chore:` / `docs:`) を付ける
- 目的ごとにコミットを分ける

## コメント

- 必要最小限にとどめる。コードを読めば分かることは書かない
- 書く場合も 1 行以内にする

## PR / Issue への画像添付は `gh --attach` を使う

`gh` は画像・動画の添付に対応している。**「gh では貼れない」と判断しない**。

```sh
gh pr edit 4818 --body-file body.md --attach './pr-pc.png#PC表示' --attach './pr-sp.png#SP表示'
gh pr create --attach ./before.png --attach ./after.png
gh issue create --attach './bug.png#エラー画面'
```

- 本文中の参照を自動で `user-attachments` URL に書き換えさせるには, **`--attach` に渡すパス文字列と本文の `![alt](...)` の中身を完全に一致させる**。本文が `./pr-pc.png` なのに `--attach /abs/path/pr-pc.png` を渡すと一致せず, ローカルパス参照が残ったまま末尾に別途追記される。相対パスで揃えるなら画像のあるディレクトリで `gh pr edit <n> -R <owner>/<repo>` を実行する。
- alt text はパスの後ろに `#` で付ける。省略時はファイル名。1 コマンド最大 50 ファイル。
- `--body` 系のフラグを付けなければ本文はそのままで添付だけ追加される。

Why: private リポジトリでは `raw.githubusercontent.com` も release asset も camo が認証できず PR 本文でレンダリングされないため, 「`user-attachments` は Web UI 専用」と誤認して手動アップロードを依頼してしまった (2026-09-21, gh 2.100.0 で確認)。

How to apply: PR / Issue にスクショを載せるときは最初から `--attach` を使う。手動アップロードの依頼やリポジトリへの画像コミットは不要。
