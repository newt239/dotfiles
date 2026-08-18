#!/bin/bash

# settings.json のリンクは home/.mise.toml の [dotfiles] が行う

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if command -v code > /dev/null; then
  echo "Installing extensions to vscode..."
  while read -r line; do
    code --install-extension "$line"
  done < "${SCRIPT_DIR}/extensions"
else
  echo "Code command not found."
fi
