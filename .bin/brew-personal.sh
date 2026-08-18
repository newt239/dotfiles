#!/bin/bash

# 私用マシンにだけ入れる cask。bootstrap -E personal の pre-packages フックから呼ばれる

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

if [ -x /opt/homebrew/bin/brew ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

brew bundle install --file "${SCRIPT_DIR}/Brewfile.personal" --force
