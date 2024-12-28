#!/bin/bash

# .mise.tomlファイルの存在を確認
if [ ! -f ".mise.toml" ]; then
  echo ".mise.tomlファイルが見つかりません。"
  exit 1
fi

# miseコマンドを実行してインストール
mise install

# インストールの結果を表示
if [ $? -eq 0 ]; then
  echo "インストールが成功しました。"
else
  echo "インストールに失敗しました。"
  exit 1
fi