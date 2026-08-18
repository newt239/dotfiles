#!/bin/bash

# mise が扱えない cask を Homebrew で入れる。bootstrap の pre-packages フックから呼ばれる

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

if [ -x /opt/homebrew/bin/brew ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/keep-sudo.sh"

brew update
brew upgrade
brew bundle install --file "${SCRIPT_DIR}/Brewfile" --force
