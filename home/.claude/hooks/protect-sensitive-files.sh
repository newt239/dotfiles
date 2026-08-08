#!/bin/bash
# PreToolUse hook: 秘密情報ファイルへの Edit/Write をブロックする (Bash 経由の書き込みは対象外)

file_path=$(jq -r '.tool_input.file_path // empty')

[ -z "$file_path" ] && exit 0

basename=$(basename "$file_path")

case "$basename" in
  .env.example | .env.sample)
    exit 0
    ;;
  .env | .env.* | *credentials* | *secret* | *.pem | *.key | id_rsa* | .netrc | .npmrc)
    jq -n '{
      hookSpecificOutput: {
        hookEventName: "PreToolUse",
        permissionDecision: "deny",
        permissionDecisionReason: "秘密情報ファイルのため編集をブロックしました"
      }
    }'
    ;;
esac

exit 0
