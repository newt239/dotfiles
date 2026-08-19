# 反映する構成。work か personal
ENV ?= work

.DEFAULT_GOAL := help

help:
	@echo "make work      業務用マシンをセットアップする"
	@echo "make personal  私用マシンをセットアップする"
	@echo "make status    宣言との差分を確認する。ENV=personal で切り替え"
	@echo "make lint      ワークフロー・シェルスクリプト・TOML を検査する"
	@echo "make raycast   Raycast の設定取り込み画面を開く"
	@echo "make chmod     .sh に実行権限を付与する"

# すべての.shファイルに対して実行権限を付与
chmod:
	find . -type f -name "*.sh" -exec chmod +x {} \;

# Xcode CLT / Homebrew / mise を用意する
init:
	@echo "\033[0;34mRun init.sh\033[0m"
	@.bin/init.sh
	@echo "\033[0;32mDone.\033[0m"

work: ENV = work
work: bootstrap

personal: ENV = personal
personal: bootstrap

# 宣言をマシンに反映する
bootstrap: init
	@echo "\033[0;34mRun mise bootstrap -E $(ENV)\033[0m"
	@mise trust home/.mise.toml
	@mise trust home/.mise.$(ENV).toml
	@mise bootstrap -C home -E $(ENV) --yes
	@echo "\033[0;32mDone.\033[0m"

# 宣言との差分を確認する
status:
	@mise bootstrap status -C home -E $(ENV)
	@mise run check-extensions

# ワークフロー・シェルスクリプト・TOML を検査する
lint:
	@mise run lint

# Raycast の設定取り込み画面を開く
raycast:
	@mise run -C home raycast
