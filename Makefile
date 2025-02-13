# すべてのスクリプトを実行する
all: init link defaults brew

# すべての.shファイルに対して実行権限を付与
chmod:
	find . -type f -name "*.sh" -exec chmod +x {} \;

# 初期設定
init:
	@echo "\033[0;34mRun init.sh\033[0m"
	@.bin/init.sh
	@echo "\033[0;34mDone.\033[0m"

# シンボリックリンクを作成
link:
	@echo "\033[0;34mRun link.sh\033[0m"
	@.bin/link.sh
	@echo "\033[0;32mDone.\033[0m"

# MacOSのデフォルト設定を変更
defaults:
	@echo "\033[0;34mRun defaults.sh\033[0m"
	@.bin/defaults.sh
	@echo "\033[0;32mDone.\033[0m"

# MacOSのアプリケーションをインストール
brew:
	@echo "\033[0;34mRun brew.sh\033[0m"
	@.bin/brew.sh
	@echo "\033[0;32mDone.\033[0m"

# VSCodeのセットアップ
vscode:
	@echo "\033[0;34mRun vscode.sh\033[0m"
	@.bin/vscode.sh
	@echo "\033[0;32mDone.\033[0m"

# 参考: 文字色変更コード
# 30m: 黒
# 31m: 赤
# 32m: 緑
# 33m: 黄
# 34m: 青
# 35m: マゼンタ
# 36m: シアン
# 37m: 白
# \033[0;32m: 緑色（通常の色設定）
# \033[0;34m: 青色（通常の色設定）
# \033[0m: リセット（色設定を元に戻す）