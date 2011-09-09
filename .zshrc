[ -e "${HOME}/.ssh/agent-env" ] && . "${HOME}/.ssh/agent-env"

fpath=($HOME/.zsh/myfunc $fpath)

autoload -Uz compinit;compinit
autoload -Uz colors;colors
autoload -Uz url-quote-magic;zle -N self-insert url-quote-magic

export ZUSERDIR=.zsh

# zsh が使うシェル変数のうちヒストリ（履歴機能）に関するもの

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt append_history
setopt extended_history
setopt share_history
if [ $UID = 0 ]; then
  unset HISTFILE
  SAVEHIST=0
fi

# core ファイルのサイズを 0 に抑制する
unlimit
limit core 0
limit -s

# ファイル作成時のデフォルトのモードを指定する
umask 022

# 端末の設定：Ctrl+H に 1 文字削除、Ctrl+C に割り込み、Ctrl+Z にサスペンド
#stty erase '^H'
#stty intr '^C'
#stty susp '^Z'

### key bindings
bindkey -e                          # EDITOR=vi -> bindkey -v
bindkey '^U' backward-kill-line     # override kill-whole-line
bindkey '^[h' vi-backward-kill-word # override run-help
bindkey '^[.' copy-prev-word        # override insert-last-word

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

if [ -f $ZUSERDIR/zshoptions ]; then
  source $ZUSERDIR/zshoptions
fi
if [ -f $ZUSERDIR/aliases ]; then
  source $ZUSERDIR/aliases
fi
if [ -f $ZUSERDIR/functions ]; then
  source $ZUSERDIR/functions
fi
if [ -f $ZUSERDIR/lscolors ]; then
  source $ZUSERDIR/lscolors
fi
if [ -f $ZUSERDIR/zshrc.user ]; then
  source $ZUSERDIR/zshrc.user
fi

if [ -n "${WINDOW}" ]; then
  preexec () {
    1="$1 "
    echo -ne "\ek${${(s: :)1}[0]}\e\\"
  }
fi

# gitで^とか~とかがextended_blobと被って困るのでなんとかする
# http://subtech.g.hatena.ne.jp/cho45/20080617/1213629154
typeset -A abbreviations
abbreviations=(
  "L"    "| $PAGER"
  "G"    "| grep"

  "HEAD^"     "HEAD\\^"
  "HEAD^^"    "HEAD\\^\\^"
  "HEAD^^^"   "HEAD\\^\\^\\^"
  "HEAD^^^^"  "HEAD\\^\\^\\^\\^\\^"
  "HEAD^^^^^" "HEAD\\^\\^\\^\\^\\^"
)

magic-abbrev-expand () {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9^]#}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}

magic-abbrev-expand-and-insert () {
  magic-abbrev-expand
  zle self-insert
}

magic-abbrev-expand-and-accept () {
  magic-abbrev-expand
  zle accept-line
}

no-magic-abbrev-expand () {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N magic-abbrev-expand-and-insert
zle -N magic-abbrev-expand-and-accept
zle -N no-magic-abbrev-expand
bindkey "\r"  magic-abbrev-expand-and-accept # M-x RET はできなくなる
bindkey "^J"  accept-line # no magic
bindkey " "   magic-abbrev-expand-and-insert
bindkey "."   magic-abbrev-expand-and-insert
bindkey "^x " no-magic-abbrev-expand

# http://www.clear-code.com/blog/2011/9/5.html
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:default' list-colors ""
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose yes
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' completer \
  _oldlist _complete _match _history _ignored _approximate _prefix

# PROMPT
prompt_bar_left_self="(%{%B%}%n%{%b%}%{%F{cyan}%}@%{%f%}%{%B%}%m%{%b%})"
prompt_bar_left_status="(%{%B%F{white}%(?.%K{black}.%K{red})%}%?%{%k%f%b%})"
prompt_bar_left_date="[%{%B%}%D{%Y/%m/%d %H:%M}%{%b%}]"
prompt_bar_left="${prompt_bar_left_self} ${prompt_bar_left_status} ${prompt_bar_left_date}"
prompt_bar_right="[%{%B%K{magenta}%F{white}%}%d%{%f%k%b%}]"
prompt_left="-%(1j,(%j),)%{%B%}%#%{%b%} "
PROMPT="${prompt_bar_left} | ${prompt_bar_right}"$'\n'"${prompt_left}"
#RPROMPT="[%{%B%F{white}%K{magenta}%}%~%{%k%f%b%}]"
