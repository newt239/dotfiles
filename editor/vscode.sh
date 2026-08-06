#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VSCODE_SETTING_PATH="${HOME}/Library/Application Support/Code/User/settings.json"

# Link settings.json to vscode
if [ -L "${VSCODE_SETTING_PATH}" ]; then
  echo "VSCode settings.json is already linked."
else
  mkdir -p "$(dirname "${VSCODE_SETTING_PATH}")"
  # Keep the existing settings as a backup before replacing it
  [ -f "${VSCODE_SETTING_PATH}" ] && mv "${VSCODE_SETTING_PATH}" "${VSCODE_SETTING_PATH}.bak"
  ln -fsvn "${SCRIPT_DIR}/settings.json" "${VSCODE_SETTING_PATH}"
fi

# Install extensions to vscode
if command -v code > /dev/null; then
  echo "Installing extensions to vscode..."
  while read -r line; do
    code --install-extension "$line"
  done < "${SCRIPT_DIR}/extensions"
else
  echo "Code command not found."
fi
