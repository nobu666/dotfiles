autoload -U compinit; compinit
bindkey "\e[3~" delete-char
export LANG=ja_JP.UTF-8
export HOSTNAME=`hostname`
export CATALINA_HOME=/usr/local/tomcat
export JAVA_HOME=/usr/lib/jvm/default-java/jre

[ -e "$HOME/.ssh/agent-env" ] && . "$HOME/.ssh/agent-env"

if [ "$TERM" = "screen" ]; then
  preexec() {
    emulate -L zsh
#    local -a cmd; cmd=(${(z)2})
#    echo -n "\ek$cmd[1]:t\e\\"
  }
fi
function ssh_screen() {
# eval server=\${$#}
 screen -t $@ ssh "$@"
}
if [ "$TERM" = "screen" ]; then
  alias ssh=ssh_screen
fi

LESS=-M
export LESS
if type /usr/bin/lesspipe.sh &>/dev/null
then
  LESSOPEN="| /usr/bin/lesspipe.sh '%s'"
  LESSCLOSE="/usr/bin/lesspipe.sh '%s' '%s'"
  export LESSOPEN LESSCLOSE
fi

local GREEN=$'%{\e[1;32m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'
PROMPT=$BLUE'[$USER@$HOSTNAME] %(!.#.$) '$DEFAULT
RPROMPT=$GREEN'[%~]'$DEFAULT
export LS_COLORS='di=01;36'

zstyle ':comletion:*' use-cache true
zstyle ':completion:*:sudo:*' command-path /home/nobu666/maven2/bin /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

HISTFILE=/home/nobu/.zsh_history
LISTMAX=10000
HISTSIZE=100000
SAVEHIST=200000000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
alias less="lv -c"
alias ls="ls --color=auto"
alias ll="ls -la --color=auto"
alias grep="grep -v grep|grep --color"
alias -g G='| grep '
alias -g L='| less '

unsetopt promptcr
setopt prompt_subst
setopt print_eight_bit
setopt append_history
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt no_beep
setopt brace_ccl
setopt extended_glob
setopt no_hup
setopt magic_equal_subst
setopt list_types
setopt interactive_comments
setopt multios
setopt numeric_glob_sort
setopt share_history
setopt autopushd
setopt listpacked
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt extended_history
setopt hist_no_store
setopt hist_no_functions
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_verify
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt transient_rprompt
setopt rc_expand_param
