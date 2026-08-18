#!/bin/bash

# 宣言とマシンの状態がずれていたら通知する。launchd から週次で呼ばれる

export PATH="/opt/homebrew/bin:${PATH}"

if mise bootstrap status -C "${HOME}/dotfiles/home" --missing > /dev/null 2>&1; then
	exit 0
fi

osascript -e 'display notification "mise bootstrap status に差分があります" with title "dotfiles"'
