#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

for dotfile in "${SCRIPT_DIR}"/.??* ; do
    [[ "$dotfile" == "${SCRIPT_DIR}/.git" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.github" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.DS_Store" ]] && continue

    ln -fnsv "$dotfile" "$HOME"
done

# 認証情報が同居するディレクトリがあるためファイル単位でリンクする
link_file() {
    mkdir -p "$(dirname "$2")"
    ln -fnsv "${REPO_DIR}/$1" "$2"
}

link_file "config/karabiner/karabiner.json" "${HOME}/.config/karabiner/karabiner.json"
link_file "config/direnv/direnvrc" "${HOME}/.config/direnv/direnvrc"
link_file "config/gh/config.yml" "${HOME}/.config/gh/config.yml"
link_file "config/ghostty/config.ghostty" "${HOME}/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
link_file "config/claude/settings.json" "${HOME}/.claude/settings.json"
link_file "editor/cursor-settings.json" "${HOME}/Library/Application Support/Cursor/User/settings.json"
