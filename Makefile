# 前提条件を整えてから宣言をマシンに反映する
all: init bootstrap

# すべての.shファイルに対して実行権限を付与
chmod:
	find . -type f -name "*.sh" -exec chmod +x {} \;

# Xcode CLT / Homebrew / mise を用意する
init:
	@echo "\033[0;34mRun init.sh\033[0m"
	@.bin/init.sh
	@echo "\033[0;32mDone.\033[0m"

# home/.mise.toml の宣言をマシンに反映する
bootstrap:
	@echo "\033[0;34mRun mise bootstrap\033[0m"
	@mise trust home/.mise.toml
	@mise bootstrap -C home --yes
	@echo "\033[0;32mDone.\033[0m"

# 私用マシン向けの上乗せまで反映する
personal:
	@echo "\033[0;34mRun mise bootstrap -E personal\033[0m"
	@mise trust home/.mise.personal.toml
	@mise bootstrap -C home -E personal --yes
	@echo "\033[0;32mDone.\033[0m"

# 宣言との差分を確認する
status:
	@mise bootstrap status -C home
	@mise run check-extensions

# ワークフロー・シェルスクリプト・TOML を検査する
lint:
	@mise run lint

# Raycast の設定取り込み画面を開く
raycast:
	@mise run -C home raycast
