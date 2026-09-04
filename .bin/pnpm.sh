#!/bin/bash

# pnpm はプロジェクトの packageManager に自分で追従するため、メジャーだけを入れる

set -euo pipefail

MAJOR="12"

export PNPM_HOME="${HOME}/Library/pnpm"
export PATH="${PNPM_HOME}/bin:${PATH}"

# カレントの packageManager に切り替わらないようリポジトリの外で聞く
installed_major() {
	[ -x "${PNPM_HOME}/bin/pnpm" ] || return 1
	(cd / && "${PNPM_HOME}/bin/pnpm" --version 2>/dev/null | cut -d. -f1)
}

if [ "$(installed_major || true)" = "${MAJOR}" ]; then
	echo "✅pnpm v${MAJOR} は導入済み"
	exit 0
fi

echo "pnpmをインストール中......"

# PNPM_HOME と PATH は .zshrc で宣言済みのため、SHELL を伏せてインストーラのシェル設定変更を止める
output="$(curl -fsSL https://get.pnpm.io/install.sh | env SHELL="" PNPM_VERSION="${MAJOR}" sh - 2>&1 || true)"

if [ "$(installed_major || true)" != "${MAJOR}" ]; then
	echo "${output}"
	echo "pnpm のインストールに失敗"
	exit 1
fi

echo "✅pnpmのインストールが完了"
