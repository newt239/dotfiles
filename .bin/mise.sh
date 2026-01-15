#!/bin/bash

source ~/.zshrc

# ~/.mise.tomlファイルの存在を確認
if [ ! -f "$HOME/.mise.toml" ]; then
  echo ".mise.tomlファイルが見つかりません。"
  echo "link.shを実行してシンボリックリンクを作成してください。"
  exit 1
fi

echo "miseでインストール中......"
mise install

# インストールの結果を表示
if [ $? -eq 0 ]; then
  echo "インストールが成功しました。"
else
  echo "インストールに失敗しました。"
  exit 1
fi
