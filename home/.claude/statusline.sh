#!/bin/bash
# statusline: モデル名・カレントディレクトリ・git ブランチ・コンテキスト使用率を表示する

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // empty')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

parts=()
[ -n "$model" ] && parts+=("$model")
[ -n "$current_dir" ] && parts+=("$(basename "$current_dir")")

if [ -n "$current_dir" ]; then
  branch=$(git -C "$current_dir" branch --show-current 2>/dev/null)
  [ -n "$branch" ] && parts+=("$branch")
fi

[ -n "$used_pct" ] && parts+=("$(printf '%.0f%%' "$used_pct")")

out=""
for part in "${parts[@]}"; do
  [ -n "$out" ] && out+=" | "
  out+="$part"
done
echo "$out"
