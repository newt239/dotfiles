#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

brew update
brew upgrade
brew bundle

# TODO: RunCatのインストール
