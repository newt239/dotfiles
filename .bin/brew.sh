#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

BREWFILE_DIR="$(cd "$(dirname "$0")" && pwd)"
brew bundle --file="$BREWFILE_DIR/Brewfile" --global