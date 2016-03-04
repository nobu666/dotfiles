# autoload
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit;compinit
autoload -Uz colors;colors
autoload -Uz url-quote-magic;zle -N self-insert url-quote-magic
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

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
export AWS_REGION=ap-northeast-1

# path
eval "$(direnv hook zsh)"
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
for D in `ls $HOME/.anyenv/envs`
do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
done
. $HOME/.anyenv/envs/pyenv/versions/2.7.9/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
. $HOME/.anyenv/envs/pyenv/versions/2.7.9/bin/aws_zsh_completer.sh

# alias
eval "$(hub alias -s)"
alias diff="colordiff"
alias less="less -R"
alias ls="ls -G -w"
alias ll="ls -l"
alias la="ls -altr"
alias df="df -h"
alias du="du -h"
alias clone="ghq get"

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
alias -g X="|xargs"

alias -s py=python
alias -s rb=ruby
alias -s {png,jpg,bmp,PNG,JPG,BMP}=imgcat
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract

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
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' completer \
  _oldlist _complete _match _history _ignored _approximate _prefix

# completion
setopt mark_dirs
setopt interactive_comments
setopt magic_equal_subst
setopt print_eight_bit
setopt extended_glob
setopt globdots

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

archey -c

fpath=($HOME/.zsh/anyframe(N-/) $fpath)
autoload -Uz anyframe-init
anyframe-init

bindkey "^r" anyframe-widget-put-history
bindkey "^x^r" anyframe-widget-execute-history
bindkey "^]" anyframe-widget-cd-ghq-repository
bindkey "^k" anyframe-widget-kill
bindkey "^b" anyframe-widget-cdr

function agvim () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

function alc() {
  if [ $# != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
  else
    w3m "http://www.alc.co.jp/"
  fi
}

function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
    *.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.Z) tar zxvf $1;;
    *.gz) gzip -d $1;;
    *.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
    *.tar) tar xvf $1;;
    *.arj) unarj $1;;
  esac
}
