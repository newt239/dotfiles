#!/bin/bash

# home/.mise.toml の [bootstrap.macos] で宣言できないものだけをここに置く

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/keep-sudo.sh"

echo "Dock に標準で入っている全てのアプリを消す（Finder とごみ箱は消えない）"
defaults write com.apple.dock persistent-apps -array

echo "Spotlight 検索を表示を OFF"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 64 "
  <dict>
    <key>enabled</key><false/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>65535</integer>
        <integer>49</integer>
        <integer>1048576</integer>
      </array>
    </dict>
  </dict>
"
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

echo "ディスプレイがオフになるまでの時間を延ばす"
sudo pmset -b displaysleep 20 && sudo pmset -c displaysleep 30

for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done
