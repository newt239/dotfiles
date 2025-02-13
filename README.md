# dotfiles

## 事前準備

- git コマンドの実行
  - terminal で git コマンドを打つと XCode 利用のためのソフトウェアインストールポップアップが表示されるのでインストールしておく
- Homebrew のインストール

```zsh
# install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# pathを通す
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

- このリポジトリを$HOME 配下に clone する

```zsh
cd ~ && git clone https://github.com/newt239/dotfiles
```

- AppStore にログイン
  - Brewfile の mas は AppStore からのインストールのため

## installation

```bash
make
```

## 権限がない場合

```bash
git update-index --chmod=+x .bin/*.sh
```

## 反映されていない設定

- システム設定
  - キーボード
    - キーボードの輝度: 0
    - 🌐 キーを押して: 何もしない
    - テキスト入力
      - 入力ソース: Google 日本語入力を選択
  - トラックパッド
    - その他のジェスチャ
      - アプリ Expose: 3 本指で下にスワイプ
- Raycast の設定インポート
  - システム > キーボード > キーボードショートカット > Spotlight にて Spotlight 検索を表示を OFF

## Git の設定

### GPG キーの設定

- https://qiita.com/dodonki1223/items/2bb296111e561c93035e#github%E3%81%A7ssh%E6%8E%A5%E7%B6%9A%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AE%E6%BA%96%E5%82%99

- https://zenn.dev/kou_pg_0131/scraps/ae44c42e9291dc

## 参考

- https://zenn.dev/tsukuboshi/articles/6e82aef942d9af
