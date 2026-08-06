#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

# init.sh で入れた直後は PATH に brew が無いため読み込む
if [ -x /opt/homebrew/bin/brew ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/keep-sudo.sh"

brew update
brew upgrade
brew bundle install --file "${SCRIPT_DIR}/Brewfile" --force

# TODO: RunCatのインストール
