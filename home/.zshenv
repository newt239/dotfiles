# Homebrew と mise-managed tools を非対話 zsh からも使えるようにする。
# .zshenv は全ての zsh で読まれるため mise の activate はここ 1 箇所だけに置く。
export PATH="/opt/homebrew/bin:$PATH"

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi
