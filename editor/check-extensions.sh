#!/bin/bash

# editor/extensions と実際にインストール済みの VSCode 拡張を比較する

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v code > /dev/null; then
	echo "Code command not found."
	exit 0
fi

if diff <(sort -f "${SCRIPT_DIR}/extensions") <(code --list-extensions | sort -f); then
	echo "VSCode 拡張は宣言どおり"
else
	echo "< が宣言のみ / > が未宣言"
	exit 1
fi
