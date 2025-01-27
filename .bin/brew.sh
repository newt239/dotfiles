#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

BREWFILE_DIR="$(cd "$(dirname "$0")" && pwd)"
brew bundle --file="$BREWFILE_DIR/Brewfile" --global

mas install 1429033973 # https://github.com/Kyome22/menubar_runcat/issues/1#issuecomment-778353093