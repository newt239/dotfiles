---
description: 変更内容を分析し、目的ごとに分割して Conventional Commits 形式でコミットする
disable-model-invocation: true
allowed-tools: "Bash(git status:*) Bash(git diff:*) Bash(git log:*)"
---

# Commit

現在の変更を分析し、目的ごとに分割してコミットします。

## 手順

1. `git status` と `git diff` (ステージ済みは `git diff --cached`) で変更内容を把握する
2. 変更を目的ごとにグループ分けする (機能追加・バグ修正・ドキュメント・設定など)
3. グループごとに対象ファイルのみ `git add` してコミットする
4. コミットメッセージは `~/.claude/CLAUDE.md` のコミットメッセージ規約に従う
5. 完了後、`git log --oneline` で作成したコミットの一覧を報告する

## 注意事項

- 無関係な変更を 1 つのコミットに混ぜない
- 秘密情報を含むファイルはステージングしない
- push は指示がない限り行わない
