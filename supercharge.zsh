#!/usr/bin/zsh

# editor
export EDITOR=vi
export VISUAL=vi

# directory stuff
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# better navigation
WORDCHARS='_-'

# colors
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
alias grep='grep --color=always'

# make
export MAKEFLAGS="-j$(nproc)"

# macros
function cgrep()
{
    [[ "$1" == "" ]] && return 1
    find \( -name "*.cc" -o -name "*.cpp" -o -name "*.c" -o -name "*.h" -o -name "*.hpp" -o -name "*.hxx" \) \
        -type f -exec grep "$@" {} +
}

function mkcdir()
{
    mkdir -p "$@"
    for A in "$@"; do
        if [ -d "$A" ]; then
            cd "$A"
            return $?
        fi
    done
}
