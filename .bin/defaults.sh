#!/bin/bash

# home/.mise.toml の [bootstrap.macos] で宣言できないものと、宣言した設定の反映を行う

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/keep-sudo.sh"

echo "ディスプレイがオフになるまでの時間を延ばす"
sudo pmset -b displaysleep 20 && sudo pmset -c displaysleep 30

# ショートカットと入力ソースの変更を反映する
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done
