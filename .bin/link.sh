#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

# 認証情報が同居するディレクトリがあるためファイル単位でリンクする
link_file() {
    mkdir -p "$(dirname "$2")"
    ln -fnsv "${REPO_DIR}/$1" "$2"
}

# home 配下は $HOME と同じ構成のため全ファイルをそのままリンクする
(cd "${REPO_DIR}/home" && find . -type f ! -name .DS_Store) | while IFS= read -r file; do
    link_file "home/${file#./}" "${HOME}/${file#./}"
done

# $HOME の外に置くもの
link_file "config/ghostty/config.ghostty" "${HOME}/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
