#!/bin/bash

# 呼び出し元のスクリプトが終わるまで sudo のタイムスタンプを維持する
sudo -v
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" 2>/dev/null || exit
done &
