#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

echo "Dockを自動的に隠す"
defaults write com.apple.dock autohide -bool true

echo ".DS_Store ファイルを作成しない"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "Finder で隠しファイルを表示"
defaults write com.apple.finder AppleShowAllFiles -bool true

echo "Finder でファイルの拡張子を表示"
defaults write com.apple.finder ShowPathbar -bool true

echo "Finder でステータスバーを表示"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Finder でタブバーを表示"
defaults write com.apple.finder ShowTabView -bool true

echo "時計のフォーマットを「曜日 日 月 時:分」にする"
defaults write com.apple.menuextra.clock DateFormat -string 'd/MMM(EEE) HH:mm:ss'

echo "キーリピートの速度を速くする"
defaults write -g InitialKeyRepeat -int 10

echo "キーリピートの待ち時間を短くする"
defaults write -g KeyRepeat -int 1

echo "タップでクリックを許可"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

echo "マウスの速度を速くする"
defaults write -g com.apple.mouse.scaling 1.5

# Use the Fn key as a standard function key
echo "Fn キーを標準のファンクションキーとして使用"
defaults write -g com.apple.keyboard.fnState -bool true

# Increase trackpad speed
echo "トラックパッドの速度を速くする"
defaults write -g com.apple.trackpad.scaling 3

# Show files with all extensions
echo "全ての拡張子のファイルを表示"
defaults write -g AppleShowAllExtensions -bool true

echo "Dock に標準で入っている全てのアプリを消す（Finder とごみ箱は消えない）"
defaults write com.apple.dock persistent-apps -array

echo "ナチュラルなスクロールを無効にする"
defaults write -g com.apple.swipescrolldirection -bool false

echo "アプリ Exposé: 3 本指で下にスワイプ"
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2

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


for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done
