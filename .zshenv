echo "Loading $HOME/.zshenv"

typeset -U path
path=(
    /bin(N-/)
    $HOME/local/bin(N-/)
    /opt/local/bin(N-/)
    /usr/local/bin(N-/)
    /usr/bin(N-/)
)
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=(
    /usr/local(N-/)
    /usr/sbin(N-/)
)

local RED=$'%{\e[1;31m%}'
local GREEN=$'%{\e[1;32m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'

export GREP_OPTIONS
GREP_OPTIONS="--binary-files=without-match"
GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"
GREP_OPTIONS="--exclude=\*.tmp $GREP_OPTIONS"
if grep --help | grep -q -- --exclude-dir; then
  GREP_OPTIONS="--exclude-dir=.svn $GREP_OPTIONS"
  GREP_OPTIONS="--exclude-dir=.git $GREP_OPTIONS"
  GREP_OPTIONS="--exclude-dir=.libs $GREP_OPTIONS"
fi
if grep --help | grep -q -- --color; then
  GREP_OPTIONS="--color=auto $GREP_OPTIONS"
fi
if [ "$PAGER" = "lv" ]; then
  export LV="-c -l"
else
  alias lv="$PAGER"
fi

precmd_functions=($precmd_functions update_prompt)
