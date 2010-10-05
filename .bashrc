HISTSIZE=50000
HISTFILESIZE=50000
HISTCONTROL=ignoreboth
HISTFILE=$HOME/contents/.bash_histroy
HISTTIMEFORMAT="%y/%m/%d %H:%M:%S  "
PS1='\[\e[01:33m\][\u@\h]\[\e[0m\]\[\e[00:32m\](\W)\[\e[0m\]$ '

export PATH=$PATH:/usr/local/bin:/usr/mesh/sbin
export LANG=ja_JP.utf8
export GREP_COLOR='1;37;41'
export GREP_OPTIONS='--binary-files=without-match --color=auto'
export LS_COLORS='di=01;36;40:'
export LSCOLORS=gxfxcxdxbxegedabagacad
export PAGER=less
export LESS='-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'
export LESSOPEN='| /usr/bin/lesspipe.sh %s'

alias ls='ls --color=auto --show-control-chars'
alias ll='ls -l'
alias grep='grep -E'

shopt -s histverify
shopt -s histappend
shopt -s histreedit
shopt -s checkwinsize
shopt -s checkhash
shopt -s no_empty_cmd_completion
shopt -s extglob

complete -d cd
complete -c which
complete -c sudo
complete -v unset

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}

_get_longopts()
{
    $1 --help | grep -o -e "--[^[:space:].,]*" | grep -e "$2" |sort -u
}

_longopts()
{
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}

    case "${cur:-*}" in
       -*)      ;;
        *)      return ;;
    esac

    case "$1" in
      \~*)      eval cmd="$1" ;;
        *)      cmd="$1" ;;
    esac
    COMPREPLY=( $(_get_longopts ${1} ${cur} ) )
}
complete  -o default -F _longopts configure bash
complete  -o default -F _longopts wget ls
