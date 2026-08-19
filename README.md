# dotfiles

[mise bootstrap](https://mise.jdx.dev/bootstrap.html) でマシンの状態を宣言的に管理する。

## セットアップ

1. terminal で git コマンドを打ち、表示されるポップアップから Xcode Command Line Tools をインストールする
2. `~/dotfiles` に clone する

```zsh
cd ~ && git clone https://github.com/newt239/dotfiles
```

3. 業務用なら `make work`、私用なら `make personal` を実行する

`home/.mise.toml` が絶対パスで参照しているため、置き場所は `~/dotfiles` 固定。

## コマンド

| コマンド | 内容 |
| --------------- | ---------------------------------------------- |
| `make work`     | 業務用マシンをセットアップする                 |
| `make personal` | 私用マシンをセットアップする                   |
| `make status`   | 宣言との差分と VSCode 拡張の差分を確認する     |
| `make lint`     | ワークフロー・シェルスクリプト・TOML を検査する |
| `make raycast`  | Raycast の設定取り込み画面を開く               |

`make status` は既定で業務用を見る。私用は `make status ENV=personal`。

セットアップ後は `~/.mise.toml` がリンクされるため、どこからでも `mise bootstrap -E work` で再収束できる。

`~/Library/Application Support/Code/User/settings.json` と `~/.ssh/config` が実ファイルとして存在するとリンクが競合する。初回のみ次を使う。

```bash
mise bootstrap -C home -E work --yes --force-dotfiles
```

## ディレクトリ構成

| ディレクトリ | 内容 |
| ------------ | ---------------------------------------- |
| `home/`      | `$HOME` と同じ構成で配置した設定ファイル |
| `packages/`  | Homebrew で入れる cask のリスト          |
| `.bin/`      | 宣言化できない処理のスクリプト           |
| `config/`    | `$HOME` の外に置く設定ファイル           |
| `editor/`    | VSCode の設定                            |
| `raycast/`   | Raycast の設定                           |

`home/` 配下は `symlink-each` でそのまま `$HOME` にリンクされる。設定ファイルを追加するときは `home/` に置くだけでよい。

`$HOME` の外へ置くものは `home/.mise.toml` の `[dotfiles]` に追加する。認証情報が同居するディレクトリがあるため、ディレクトリ単位の一括リンクは行わない。

リポジトリ直下の `mise.toml` はこのリポジトリ自体の開発用。`$HOME` に配る設定は `home/.mise.toml` に置く。

## 業務用と私用

アプリのリストは 2 つの構成で完全に独立している。片方のファイルを見れば、そのマシンに入るアプリが全部分かる。

| | 業務用 | 私用 |
| --- | --- | --- |
| コマンド | `make work` | `make personal` |
| cask | `packages/Brewfile.work` | `packages/Brewfile.personal` |
| App Store アプリ | `home/.mise.work.toml` | `home/.mise.personal.toml` |
| コミット署名 | GPG | 1Password の SSH キー |

`home/.mise.toml` は両方に共通する部分で、`[tools]`・dotfiles・macOS 設定・formula を持つ。アプリは置かない。

## mise

`mise use -g` は `~/.config/mise/config.toml` を作成して設定が二重管理になるため使用しない。

### 宣言化していないもの

| 内容 | 置き場所 | 呼び出し元 |
| ---------------------------------------------- | ------------------------------ | ---------------------- |
| cask のインストール                            | `packages/` と `.bin/brew.sh`  | `pre-packages` フック  |
| Dock のアプリ消去・Spotlight ホットキー・`pmset` | `.bin/defaults.sh`             | `post-defaults` フック |
| VSCode 拡張のインストール                      | `editor/vscode.sh`             | `bootstrap` タスク     |

cask は mise が Homebrew 管理下のものを引き取れず `Homebrew owns this cask` で失敗するため、Homebrew に残している。formula と App Store アプリは `[bootstrap.packages]` で管理している。

`[bootstrap.hooks]` は上書きではなく追記される。構成ごとに違う処理をさせたい場合は、同じフックに別のコマンドを足す形になる。

### マシン固有の上書き

`home/.gitconfig` は末尾で `~/.gitconfig.local` を include している。存在しなければ無視されるため、署名方式のようにマシンごとに変えたい設定はそちらに置く。

## 手動で設定するもの

- システム設定 > キーボード
  - キーボードの輝度: 0
  - テキスト入力 > 入力ソース
    - Google 日本語入力を選択する
    - 「ABC」を削除する。初期状態では「−」ボタンが無効なので、「日本語 - かな入力」の「英字」にチェックを入れて有効にする
    - ref: https://www.karakaram.com/deleting-alphanumeric-input-sources-on-macos-bigsur/
- Raycast の設定インポート
  - `make raycast` で開く画面から `raycast/rayconfig` を選び、パスフレーズを入力する

`🌐 キーを押して: 何もしない` は宣言済み。反映には再起動が必要。

## コミット署名の準備

`commit.gpgsign = true` を常に有効にしているため、鍵の準備ができていないマシンではコミットが失敗する。構成ごとに手順が違う。

### 業務用

GPG 鍵で署名する。`gnupg` と `pinentry-mac` は `make work` が入れる。`~/.gnupg/gpg-agent.conf` も配置され、パスフレーズの入力に pinentry-mac を使う。

1. 鍵を用意する。既存の鍵を移すならエクスポートしたものを `gpg --import` する

```bash
gpg --full-generate-key
```

2. 鍵 ID を調べ、`home/.gitconfig` の `user.signingkey` を書き換える

```bash
gpg --list-secret-keys --keyid-format=long
```

3. 公開鍵を GitHub の Settings > SSH and GPG keys > New GPG key に登録する

```bash
gpg --armor --export <鍵ID>
```

- ref: https://zenn.dev/kou_pg_0131/scraps/ae44c42e9291dc

### 私用

1Password の SSH キーで署名する。GPG 鍵は不要。

1. 1Password の設定で SSH エージェントを有効にする。`~/.ssh/config` は `make personal` が配置する
2. 署名に使う SSH キーを 1Password に用意する
3. 公開鍵を GitHub の Settings > SSH and GPG keys > New SSH key に登録する。**Key type を Signing Key にする**。認証用に登録済みの鍵でも、署名用は別枠で登録がいる
4. その鍵に合わせて `config/git/gitconfig.personal` の `user.signingkey` と `config/git/allowed_signers` を書き換える
5. `make personal` を実行する

`make personal` が `~/.gitconfig.local` を作り、署名方式が SSH に切り替わる。3 を飛ばすと署名は付くが GitHub 上で Verified にならない。

- ref: https://qiita.com/dodonki1223/items/2bb296111e561c93035e#github%E3%81%A7ssh%E6%8E%A5%E7%B6%9A%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AE%E6%BA%96%E5%82%99

## 権限がない場合

```bash
git update-index --chmod=+x .bin/*.sh
```

## 参考

- https://zenn.dev/tsukuboshi/articles/6e82aef942d9af
- https://zenn.dev/boykush/articles/8d3f52c1a97b04
