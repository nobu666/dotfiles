export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export PYTHONPATH="$HOME/.anyenv/envs/pyenv/versions/2.7.9/lib/python2.7/site-packages"
export HOMEBREW_GITHUB_API_TOKEN=$(security 2>&1 >/dev/null find-generic-password -ga homebrew-github-api-key | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/')
export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2376
export DOCKER_CERT_PATH=$HOME/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
export AWS_ACCESS_KEY=$(grep aws_access ~/.aws/credentials | awk -F= '{print $2}' | tr -d ' ')
export AWS_SECRET_ACCESS_KEY=$(grep aws_secret ~/.aws/credentials | awk -F= '{print $2}' | tr -d ' ')

# path
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
for D in `ls $HOME/.anyenv/envs`
do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
done
. $HOME/.anyenv/envs/pyenv/versions/2.7.9/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
. $HOME/.anyenv/envs/pyenv/versions/2.7.9/bin/aws_zsh_completer.sh

# autoload
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit;compinit
autoload -Uz colors;colors
autoload -Uz url-quote-magic;zle -N self-insert url-quote-magic
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

# alias
alias diff='colordiff'
alias less='less -R'
alias ls='ls -G -w'
alias ll="ls -l"
alias la="ls -altr"
alias df="df -h"
alias du="du -h"

alias -g C="|cat"
alias -g H="|head"
alias -g S="|sort"
alias -g U="|uniq"
alias -g T="|tail"
alias -g G="|grep"
alias -g L="|less"
alias -g W="|wc"
alias -g S="|sed"
alias -g A="|awk"

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
DIRSTACKSIZE=100
setopt auto_pushd
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_no_store
setopt share_history
if [ $UID = 0 ]; then
  unset HISTFILE
  SAVEHIST=0
fi

# core
unlimit
limit core 0
limit -s

# mode
umask 022

# key bindings
bindkey -e                          # EDITOR=vi -> bindkey -v
bindkey '^U' backward-kill-line     # override kill-whole-line
bindkey '^[h' vi-backward-kill-word # override run-help
bindkey '^[.' copy-prev-word        # override insert-last-word

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

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

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
