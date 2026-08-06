# Ensure mise-managed tools are available in non-interactive zsh shells.
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi
