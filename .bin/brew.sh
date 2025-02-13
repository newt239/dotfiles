#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

sudo brew update
sudo brew upgrade
sudo brew bundle

# TODO: RunCatのインストール