

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$PATH:/BUN_INSTALL/bin"
export PATH="$PATH:/Users/newt/development/flutter/bin"

eval "$(rbenv init - zsh)"

export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:/Users/newt/development/atcoder/ac-library"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
