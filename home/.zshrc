#################################  HISTORY  #################################
# history
HISTFILE=$HOME/.zsh-history # 履歴を保存するファイル
HISTSIZE=100000             # メモリ上に保存する履歴のサイズ
SAVEHIST=1000000            # 上述のファイルに保存する履歴のサイズ

# share .zshhistory
setopt inc_append_history   # 実行時に履歴をファイルにに追加していく
setopt share_history        # 履歴を他のシェルとリアルタイム共有する

#################################  COMPLEMENT  #################################
# enable completion
autoload -Uz compinit && compinit

# 補完候補をそのまま探す -> 小文字を大文字に変えて探す -> 大文字を小文字に変えて探す
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

### 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''


### 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2

#################################  OTHERS  #################################
# automatically change directory when dir name is typed
setopt auto_cd

# disable ctrl+s, ctrl+q
setopt no_flow_control

###############################  INSTALLATION  ############################

# Git
export GPG_TTY=$(tty)

# Bun
export PATH="$PATH:/BUN_INSTALL/bin"
export PATH="$HOME/.local/bin:$PATH"

eval "$(direnv hook zsh)"

# Android Studio
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools

###############################  PROMPT  ############################

autoload -Uz vcs_info

precmd() {
  vcs_info
}

# Gitブランチ名を緑で表示
zstyle ':vcs_info:git:*' formats ' %F{green}[%b]%f'

setopt prompt_subst

# ユーザー名@ホスト名を白文字 + 濃いグレー背景
PROMPT='%K{238}%F{white} %n@%m %f%k %F{39}%1~%f${vcs_info_msg_0_} %F{196}%#%f '
