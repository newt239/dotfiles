#!/bin/zsh

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/keep-sudo.sh"

# 次回以降の sudo を Touch ID で認証できるようにする
if [ ! -f /etc/pam.d/sudo_local ] && [ -f /etc/pam.d/sudo_local.template ]; then
	sed 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local > /dev/null
	echo "✅sudoのTouch IDを有効化"
fi

if [ "$SHELL" != "/bin/zsh" ]; then
	chsh -s /bin/zsh
	echo "✅シェルをzshに変更"
fi

echo "Xcode Command Line Toolsをインストール中......"
xcode-select --install
echo "✅Xcode Command Line Toolsのインストールが完了"

echo "Homebrewをインストール中......"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "✅Homebrewのインストールが完了"