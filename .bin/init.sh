#!/bin/zsh

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

chsh -s /bin/zsh
echo "✅シェルをzshに変更"

echo "Homebrewをインストール中......"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "✅Homebrewのインストールが完了"