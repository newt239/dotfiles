---
description: Git 変更分析に基づく自動 PR 作成。変更内容を分析し、適切な説明文とラベルで PR を作成します。
---

# Create PR

Git 変更分析に基づく自動 PR 作成で効率的な Pull Request ワークフローを実現します。

## 使い方

```bash
# 変更分析による自動 PR 作成
git add . && git commit -m "feat: ユーザー認証機能の実装"
「変更内容を分析して適切な説明文とラベルで PR を作成してください」

# PR テンプレートが存在する場合の保持更新
[ -f .github/PULL_REQUEST_TEMPLATE.md ] && cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
「テンプレート構造を完全に保持して変更内容を補完してください」
```

## 基本例

```bash
# 1. ブランチ作成とコミット
git checkout main && git pull
git checkout -b feat/user-profile
git add . && git commit -m "feat: ユーザー プロフィール機能の実装"
git push -u origin feat/user-profile

# 2. PR 作成
「以下の手順で PR を作成してください：
1. git diff --cached で変更内容を確認
2. PR テンプレートが存在する場合はそれを使用して説明文を作成
3. 変更内容から適切なラベルを最大 3 個選択
4. 通常の PR として作成 (HTML コメント保持)」
5. PR名はブランチ名を参考に、例えばfeatureブランチならば、「feat: ユーザー プロフィール機能の実装」のように作成してください。また、PR名は日本語で作成してください。

format `{区分}: {内容}`
例: feat: ユーザー プロフィール機能の実装
```

## 実行手順

### 1. ブランチ作成

```bash
# ガイドラインに従った命名規則: {type}/{subject}
git checkout main
git pull
git checkout -b feat/user-authentication

# ブランチ確認 (現在のブランチ名を表示)
git branch --show-current
```

### 2. コミット

```bash
# 変更をステージング
git add .

# ガイドラインに従ったコミットメッセージ
git commit -m "feat: ユーザー認証 API の実装"
```

### 3. リモートに Push

```bash
# 初回 Push(upstream 設定)
git push -u origin feat/user-authentication

# 2 回目以降
git push
```

### 4. 自動分析による PR 作成

**Step 1: 変更内容の分析**

```bash
# ファイル変更の取得 (ステージ済み変更を確認)
git diff --cached --name-only

# 内容分析 (最大 1000 行)
git diff --cached | head -1000
```

**Step 2: 説明文の自動生成**

```bash
# テンプレート処理の優先順位
# 1. 既存 PR 説明 (完全保持)
# 2. PR テンプレート (存在する場合のみ)
# 3. 変更内容から生成した説明文

# テンプレートの存在確認 (最初に見つかったものを使用)
ls .github/PULL_REQUEST_TEMPLATE.md .github/pull_request_template.md PULL_REQUEST_TEMPLATE.md 2>/dev/null

# 存在する場合のみコピーして利用
[ -f .github/PULL_REQUEST_TEMPLATE.md ] && cp .github/PULL_REQUEST_TEMPLATE.md pr_body.md
# HTML コメント・区切り線を保持したまま空セクションのみ補完
```

**Step 3: ラベルの自動選択**

```bash
# 利用可能ラベルの取得 (非インタラクティブ)
「.github/labels.yml または GitHub リポジトリから利用可能なラベルを取得して、変更内容に基づいて適切なラベルを自動選択してください」

# パターンマッチングによる自動選択 (最大 3 個)
# - ドキュメント: *.md, docs/ → documentation|docs
# - テスト: test, spec → test|testing
# - バグ修正: fix|bug → bug|fix
# - 新機能: feat|feature → feature|enhancement
```

**Step 4: GitHub API での PR 作成 (HTML コメント保持)**

```bash
# PR 作成
「以下の情報で PR を作成してください：
- タイトル: コミットメッセージから自動生成
- 説明文: PR テンプレートが存在する場合はそれを使用し、無い場合は変更内容から生成
- ラベル: 変更内容から自動選択 (最大 3 個)
- ベースブランチ: main
- HTML コメントは完全に保持」
```

**方法 B: GitHub MCP(フォールバック)**

```javascript
// HTML コメント保持での PR 作成
mcp_github_create_pull_request({
  owner: "organization",
  repo: "repository",
  base: "main",
  head: "feat/user-authentication",
  title: "feat: ユーザー認証の実装",
  body: prBodyContent, // HTML コメントを含む完全な内容
  maintainer_can_modify: true,
});
```

## 自動ラベル選択システム

### ファイルパターンベース判定

- **ドキュメント**: `*.md`, `README`, `docs/` → `documentation|docs|doc`
- **テスト**: `test`, `spec` → `test|testing`
- **CI/CD**: `.github/`, `*.yml`, `Dockerfile` → `ci|build|infra|ops`
- **依存関係**: `package.json`, `pubspec.yaml` → `dependencies|deps`

### 変更内容ベース判定

- **バグ修正**: `fix|bug|error|crash|修正` → `bug|fix`
- **新機能**: `feat|feature|add|implement|新機能|実装` → `feature|enhancement|feat`
- **リファクタリング**: `refactor|clean|リファクタ` → `refactor|cleanup|clean`
- **パフォーマンス**: `performance|perf|optimize` → `performance|perf`
- **セキュリティ**: `security|secure` → `security`

### 制約事項

- **最大 3 個まで**: 自動選択の上限
- **既存ラベルのみ**: 新規作成禁止
- **部分マッチ**: キーワード含有による判定

## プロジェクトガイドライン

### 基本姿勢

1. **通常の PR で作成**: Draft ではなく Ready for Review の状態で作成
2. **適切なラベル**: 最大 3 種類のラベルを必ず付与
3. **テンプレート使用**: PR テンプレートが存在する場合のみ使用し、無い場合は変更内容から説明文を生成
4. **日本語スペース**: 日本語と半角英数字間に必ず半角スペース

### ブランチ命名規則

```text
{type}/{subject}

例:
- feat/user-profile
- fix/login-error
- refactor/api-client
```

### コミットメッセージ

```text
{type}: {description}

例:
- feat: ユーザー認証 API の実装
- fix: ログイン エラーの修正
- docs: README の更新
```

## テンプレート処理システム

### 処理優先順位

1. **既存 PR 説明**: 既に記述されている内容を**完全に踏襲**
2. **プロジェクトテンプレート**: PR テンプレートが存在する場合はその構造を維持
3. **変更内容から生成**: テンプレートが存在しない場合は変更内容を要約した説明文を作成

### テンプレートの探索先

以下を順に確認し、最初に見つかったものを使用する。いずれも存在しない場合はテンプレートを使わない。

- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/pull_request_template.md`
- リポジトリ ルートの `PULL_REQUEST_TEMPLATE.md`

### 既存内容保持ルール

- **一文字も変更しない**: 既に記述されている内容
- **空セクションのみ補完**: プレースホルダー部分を変更内容で埋める
- **機能的コメント保持**: `<!-- Copilot review rule -->` などを維持
- **HTML コメント保持**: `<!-- ... -->` を完全に保持
- **区切り線保持**: `---` などの構造を維持

### HTML コメント保持の対処法

**重要**: GitHub CLI (`gh pr edit`) は HTML コメントを自動エスケープし、シェル処理で `EOF < /dev/null` などの不正な文字列が混入する場合があります。

**根本的解決策**:

1. **GitHub API の --field オプション使用**: 適切なエスケープ処理で HTML コメント保持
2. **テンプレート処理の簡素化**: 複雑なパイプ処理やリダイレクトを避ける
3. **完全保持アプローチ**: HTML コメント削除処理を廃止し、テンプレートを完全保持

## レビューコメント対応

```bash
# 変更後の再コミット
git add .
git commit -m "fix: レビュー フィードバックに基づく修正"
git push
```

## 注意事項

### HTML コメント保持の重要性

- **GitHub CLI 制限**: `gh pr edit` は HTML コメントをエスケープ、不正文字列混入
- **根本的回避策**: GitHub API の `--field` オプションで適切なエスケープ処理
- **テンプレート完全保持**: HTML コメント削除処理を廃止し、構造を完全維持

### 自動化の制約

- **新規ラベル禁止**: `.github/labels.yml` 定義外のラベル作成不可
- **最大 3 ラベル**: 自動選択の上限
- **既存内容優先**: 手動で記述された内容は一切変更しない

### 品質確認

- **Draft を使わない**: PR は最初から Ready for Review の状態で作成
- **CI 確認**: `gh pr checks` で状態確認
- **テンプレート遵守**: 存在する場合はプロジェクト固有の構造を維持

## ユーザーへの報告内容

```
PR を作成しました。

## 利用したスキル/エージェント
<!-- 実行中に実際に呼び出したスキル/エージェントを列挙。呼び出さなかったものは記載しない -->

| 種別 | 識別子 | 用途 |
|------|--------|------|
| {種別} | `{id}` | {実際の用途} |

※ 利用なしの場合は「なし」と記載

## 作成された PR

- PR URL: {URL}
- タイトル: {タイトル}
- ラベル: {ラベル}

## 次のステップ

1. CI の完了を確認
2. レビュアーをアサイン
```
