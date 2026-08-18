# dotfiles

[mise bootstrap](https://mise.jdx.dev/bootstrap.html) でマシンの状態を宣言的に管理する。

## セットアップ

1. terminal で git コマンドを打ち、表示されるポップアップから Xcode Command Line Tools をインストールする
2. `~/dotfiles` に clone する

```zsh
cd ~ && git clone https://github.com/newt239/dotfiles
```

3. `make` を実行する

`home/.mise.toml` が絶対パスで参照しているため、置き場所は `~/dotfiles` 固定。

## コマンド

| コマンド | 内容 |
| --------------- | ---------------------------------------------- |
| `make`          | 前提条件を整えてから宣言を反映する             |
| `make personal` | 私用マシン向けの上乗せまで反映する             |
| `make status`   | 宣言との差分と VSCode 拡張の差分を確認する     |
| `make lint`     | ワークフロー・シェルスクリプト・TOML を検査する |
| `make raycast`  | Raycast の設定取り込み画面を開く               |

セットアップ後は `~/.mise.toml` がリンクされるため、どこからでも `mise bootstrap` で再収束できる。

`~/Library/Application Support/Code/User/settings.json` と `~/.ssh/config` が実ファイルとして存在するとリンクが競合する。初回のみ次を使う。

```bash
mise bootstrap -C home --yes --force-dotfiles
```

## ディレクトリ構成

| ディレクトリ | 内容 |
| ------------ | ----------------------------------------- |
| `home/`      | `$HOME` と同じ構成で配置した設定ファイル  |
| `.bin/`      | 宣言化できない処理のスクリプトと Brewfile |
| `config/`    | `$HOME` の外に置く設定ファイル            |
| `editor/`    | VSCode の設定                             |
| `raycast/`   | Raycast の設定                            |

`home/` 配下は `symlink-each` でそのまま `$HOME` にリンクされる。設定ファイルを追加するときは `home/` に置くだけでよい。

`$HOME` の外へ置くものは `home/.mise.toml` の `[dotfiles]` に追加する。認証情報が同居するディレクトリがあるため、ディレクトリ単位の一括リンクは行わない。

リポジトリ直下の `mise.toml` はこのリポジトリ自体の開発用。`$HOME` に配る設定は `home/.mise.toml` に置く。

## mise

`home/.mise.toml` が唯一の宣言ファイルで、`[tools]` と bootstrap の全セクションをまとめている。

`mise use -g` は `~/.config/mise/config.toml` を作成して設定が二重管理になるため使用しない。

### 宣言化していないもの

| 内容 | 置き場所 | 呼び出し元 |
| ---------------------------------------------- | ------------------------------- | ------------------- |
| cask のインストール                            | `.bin/Brewfile` / `.bin/brew.sh` | `pre-packages` フック |
| Dock のアプリ消去・Spotlight ホットキー・`pmset` | `.bin/defaults.sh`              | `post-defaults` フック |
| VSCode 拡張のインストール                      | `editor/vscode.sh`              | `bootstrap` タスク  |

cask は mise が Homebrew 管理下のものを引き取れず `Homebrew owns this cask` で失敗するため、Homebrew に残している。formula と App Store アプリは `[bootstrap.packages]` で管理している。

### 業務用と私用の切り替え

`home/.mise.toml` は業務でも使う最小構成。私用マシンで足すものは `home/.mise.personal.toml` に置き、`make personal` で上乗せする。

| | 業務用 | 私用 |
| --- | --- | --- |
| コマンド | `make` | `make personal` |
| 宣言 | `home/.mise.toml` | 左記 + `home/.mise.personal.toml` |
| cask | `.bin/Brewfile` | 左記 + `.bin/Brewfile.personal` |
| コミット署名 | GPG | 1Password の SSH キー |

`[bootstrap.hooks]` は上書きではなく追記されるため、私用向けの cask は `.bin/brew-personal.sh` を別のフックとして足している。

### マシン固有の上書き

`home/.gitconfig` は末尾で `~/.gitconfig.local` を include している。存在しなければ無視されるため、署名方式のようにマシンごとに変えたい設定はそちらに置く。

`make personal` はここに `config/git/gitconfig.personal` をリンクし、コミット署名を 1Password の SSH キーに切り替える。`home/.gitconfig` 単体では 1Password に依存しない GPG 署名になる。

1Password 署名を使うには、SSH 公開鍵を GitHub に Signing Key として登録する必要がある。

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

## GPG キーの設定

- https://qiita.com/dodonki1223/items/2bb296111e561c93035e#github%E3%81%A7ssh%E6%8E%A5%E7%B6%9A%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AE%E6%BA%96%E5%82%99
- https://zenn.dev/kou_pg_0131/scraps/ae44c42e9291dc

## 権限がない場合

```bash
git update-index --chmod=+x .bin/*.sh
```

## 参考

- https://zenn.dev/tsukuboshi/articles/6e82aef942d9af
- https://zenn.dev/boykush/articles/8d3f52c1a97b04
