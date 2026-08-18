#!/bin/bash

# mise が扱えない cask を Homebrew で入れる。bootstrap の pre-packages フックから呼ばれる

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

if [ $# -ne 1 ]; then
	echo "usage: brew.sh <work|personal>"
	exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="${SCRIPT_DIR}/../packages/Brewfile.$1"

if [ ! -f "${BREWFILE}" ]; then
	echo "Brewfile not found: ${BREWFILE}"
	exit 1
fi

if [ -x /opt/homebrew/bin/brew ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

source "${SCRIPT_DIR}/keep-sudo.sh"

brew update
brew upgrade
brew bundle install --file "${BREWFILE}" --force
