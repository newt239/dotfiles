#!/bin/bash

source ~/.zshrc

# .mise.tomlファイルの存在を確認
if [ ! -f "./.mise.toml" ]; then
  echo ".mise.tomlファイルが見つかりません。"
  exit 1
fi

echo "miseでインストール中......"
mise use -g node
mise use -g bun
mise use -g cmake
mise use -g deno
mise use -g ffmpeg
mise use -g go
mise use -g pnpm
mise use -g rust

# インストールの結果を表示
if [ $? -eq 0 ]; then
  echo "インストールが成功しました。"
else
  echo "インストールに失敗しました。"
  exit 1
fi