#!/bin/bash

# Dotfilesディレクトリを固定
DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)

# デバッグモードのフラグ（デフォルト: false）
DEBUG=false

# オプション解析
while getopts "d" opt; do
  case $opt in
    d)
      DEBUG=true
      ;;
    *)
      echo "Usage: $0 [-d (debug mode)]"
      exit 1
      ;;
  esac
done

# 処理の開始メッセージ
echo "Setting up dotfiles from: ${DOTFILES_DIR}"
[ "$DEBUG" = true ] && echo "Running in DEBUG mode. No changes will be made."

# dotfilesディレクトリ内の隠しファイルに対してループ
for f in .??*; do
    # 特定のファイルをスキップ
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    [ "$f" = ".gitmodules" ] && continue

    # シンボリックリンクを作成（またはデバッグ出力）
    if [ "$DEBUG" = true ]; then
        echo "DEBUG: Link would be created: ${DOTFILES_DIR}/$f -> ~/$f"
    else
        ln -snfv "${DOTFILES_DIR}/$f" ~/
    fi
done

# ~/.config/git ディレクトリを確認
mkdir -p ~/.config/git

# Global gitignoreのシンボリックリンクを作成
GLOBAL_GITIGNORE="${DOTFILES_DIR}/.gitignore"
ln -snfv "$GLOBAL_GITIGNORE" ~/.config/git/ignore
echo "Global gitignore linked to: ~/.config/git/ignore -> $GLOBAL_GITIGNORE"

# 処理完了メッセージ
if [ "$DEBUG" = true ]; then
    echo "DEBUG mode complete. No changes were made."
else
    echo "Dotfiles setup complete."
fi
