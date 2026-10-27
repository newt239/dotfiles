# dotfiles

[mise bootstrap](https://mise.jdx.dev/bootstrap.html) でマシンの状態を宣言的に管理する。

## セットアップ

1. terminal で git を実行し、Xcode Command Line Tools をインストールする
2. `~/dotfiles` に clone する。絶対パスで参照しているため置き場所は固定

```zsh
cd ~ && git clone https://github.com/newt239/dotfiles
```

3. 業務用なら `make work`、私用なら `make personal` を実行する

`settings.json` や `~/.ssh/config` が実ファイルで残っているとリンクが競合する。その場合は次を使う。

```bash
mise bootstrap -C home -E work --yes --force-dotfiles
```

## コマンド

| コマンド | 内容 |
| --- | --- |
| `make work` / `make personal` | セットアップ・再収束する |
| `make status` | 宣言との差分を確認する。私用は `ENV=personal` |
| `make upgrade` | 宣言したパッケージを更新する |
| `make lint` | ワークフロー・シェルスクリプト・TOML を検査する |
| `make raycast` | Raycast の設定取り込み画面を開く |

## 構成

| パス | 内容 |
| --- | --- |
| `home/` | `$HOME` にそのままリンクされる設定ファイル |
| `home/.mise.toml` | 共通のツール・formula・dotfiles・macOS 設定 |
| `home/.mise.work.toml` | 業務用のアプリと Dock |
| `home/.mise.personal.toml` | 私用のアプリと Dock |
| `config/` | `$HOME` の外に置く設定ファイル |
| `editor/` | VSCode の設定と拡張 |
| `.bin/` | 宣言できない処理のスクリプト |
| `mise.toml` | このリポジトリ自体の開発用 |

アプリのリストは業務用と私用で完全に独立させる。

## 注意

- `mise use -g` は設定が二重管理になるため使わない
- pnpm はプロジェクトの `packageManager` に従わせるため `[tools]` で固定しない
- `[bootstrap.hooks]` は構成をまたいで追記される
- Homebrew で入れた cask を mise に移すには `brew uninstall --cask <name>` してから再実行する
- マシンごとの git 設定は `~/.gitconfig.local` に置く
- 入力ソースは全置換のため、手で足したものは消える。反映には再ログインが必要

## 手動で設定するもの

- キーボードの輝度を 0 にする。`defaults` に書き場所が無い
- `make raycast` で開く画面から `raycast/rayconfig` を取り込む。パスフレーズで暗号化されている

## コミット署名

`commit.gpgsign = true` のため、鍵を用意するまでコミットは失敗する。

### 業務用

GPG 鍵で署名する。

1. `gpg --full-generate-key` で鍵を作るか、既存の鍵を `gpg --import` する
2. `gpg --list-secret-keys --keyid-format=long` で鍵 ID を調べ、`home/.gitconfig` の `user.signingkey` に書く
3. `gpg --armor --export <鍵ID>` の出力を GitHub に GPG key として登録する

### 私用

1Password の SSH キーで署名する。

1. 1Password で SSH エージェントを有効にし、署名用のキーを用意する
2. 公開鍵を GitHub に **Signing Key** として登録する。認証用とは別枠
3. `config/git/gitconfig.personal` の `user.signingkey` と `config/git/allowed_signers` を書き換える
4. `make personal` を実行する

## 実行権限がない場合

```bash
git update-index --chmod=+x .bin/*.sh
```
