#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
brew update
brew upgrade
brew bundle install --file "${SCRIPT_DIR}/Brewfile" --force

# TODO: RunCatのインストール
