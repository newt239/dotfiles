# dotfiles

[mise bootstrap](https://mise.jdx.dev/bootstrap.html) でマシンの状態を宣言的に管理する。

## セットアップ手順

1. git コマンドを実行する

terminal で git コマンドを打つと XCode 利用のためのソフトウェアインストールポップアップが表示されるのでインストールしておく

2. このリポジトリを `~/dotfiles` に clone する

```zsh
cd ~ && git clone https://github.com/newt239/dotfiles
```

`home/.mise.toml` が `~/dotfiles` を絶対パスで参照しているため、置き場所は `~/dotfiles` 固定。

## installation

```bash
make
```

`make init` が Xcode Command Line Tools・Homebrew・mise を用意し、`make bootstrap` が `home/.mise.toml` の宣言をマシンに反映する。

| コマンド | 内容 |
| ---------------- | -------------------------------------------- |
| `make` | `init` → `bootstrap` |
| `make status` | 宣言との差分を確認する |
| `make raycast` | Raycast の設定取り込み画面を開く |

セットアップ後は `~/.mise.toml` がリンクされるので、どこからでも `mise bootstrap` で再収束できる。

VSCode の `settings.json` が既にファイルとして存在する場合はリンクが競合するため、初回のみ `mise bootstrap -C home --yes --force-dotfiles` で上書きする。

## ディレクトリ構成

| ディレクトリ | 内容 |
| ------------ | ---------------------------------------- |
| `home/`      | `$HOME` と同じ構成で配置した設定ファイル |
| `.bin/`      | 宣言化できない処理のスクリプトと Brewfile |
| `config/`    | `$HOME` の外に置く設定ファイル           |
| `editor/`    | VSCode の設定                            |
| `raycast/`   | Raycast の設定                           |

`home/` 配下は `[dotfiles]` の `symlink-each` で全ファイルがそのまま `$HOME` にリンクされるため、設定ファイルを追加するときは `home/` に置くだけでよい。

`~/Library/Application Support` 配下のように `$HOME` の外へ置くものは `home/.mise.toml` の `[dotfiles]` に追加する。認証情報が同居するディレクトリがあるため、ディレクトリ単位の一括リンクは行わない。

## 権限がない場合

```bash
git update-index --chmod=+x .bin/*.sh
```

## mise

`home/.mise.toml` が唯一の宣言ファイルで、`[tools]` と bootstrap の全セクションをここにまとめている。

`mise use -g` は `~/.config/mise/config.toml` を作成して設定が二重管理になるため使用しない。

### 宣言化していないもの

| 内容 | 置き場所 |
| ---- | -------- |
| cask のインストール | `.bin/Brewfile`（`pre-packages` フックから `.bin/brew.sh`） |
| Dock のアプリ消去 / Spotlight ホットキー / `pmset` | `.bin/defaults.sh`（`post-defaults` フック） |
| VSCode 拡張のインストール | `editor/vscode.sh`（`bootstrap` タスク） |

cask は mise が Homebrew 管理下のものを引き取れず `Homebrew owns this cask` で失敗するため、Homebrew に残している。formula は `[bootstrap.packages]` で管理している。

## 反映されていない設定

以下の設定は宣言できないため、手動で設定してください。

- システム設定 > キーボード
  - キーボードの輝度: 0
  - テキスト入力
    - 入力ソース: Google 日本語入力を選択
    - 入力ソース「ABC」の削除
      - 初期状態では「−」ボタンが無効で削除できない
      - 「日本語 - かな入力」の「英字」にチェックを入れると「−」ボタンが有効になり削除できる
      - ref: https://www.karakaram.com/deleting-alphanumeric-input-sources-on-macos-bigsur/
- Raycast の設定インポート
  - `make raycast` で取り込み画面が開くので、`raycast/rayconfig` を選んでパスフレーズを入力する

`🌐 キーを押して: 何もしない` は `AppleFnUsageType` として宣言済み。反映には再起動が必要。

## Git の設定

### GPG キーの設定

- https://qiita.com/dodonki1223/items/2bb296111e561c93035e#github%E3%81%A7ssh%E6%8E%A5%E7%B6%9A%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AE%E6%BA%96%E5%82%99

- https://zenn.dev/kou_pg_0131/scraps/ae44c42e9291dc

## 参考

- https://zenn.dev/tsukuboshi/articles/6e82aef942d9af
- https://zenn.dev/boykush/articles/8d3f52c1a97b04
