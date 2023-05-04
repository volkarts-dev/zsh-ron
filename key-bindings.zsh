#!/usr/bin/zsh

# copyright oh-my-zsh contributers
#
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init()
    {
        echoti smkx
    }
    function zle-line-finish()
    {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

function _zzr_bindkey()
{
    bindkey -M emacs "$1" $2
    bindkey -M viins "${terminfo[kpp]}" up-line-or-history
    bindkey -M vicmd "${terminfo[kpp]}" up-line-or-history
}

# Use emacs key bindings
bindkey -e

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
    _zzr_bindkey "${terminfo[kpp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
    _zzr_bindkey "${terminfo[knp]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search

    _zzr_bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search

    _zzr_bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
    _zzr_bindkey "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
    _zzr_bindkey "${terminfo[kend]}"  end-of-line
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
    _zzr_bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
_zzr_bindkey '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
    _zzr_bindkey "${terminfo[kdch1]}" delete-char
else
    _zzr_bindkey "^[[3~" delete-char

    _zzr_bindkey "^[3;5~" delete-char
fi

# [Ctrl-Delete] - delete whole forward-word
_zzr_bindkey '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
_zzr_bindkey '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
_zzr_bindkey '^[[1;5D' backward-word

# [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey '^r' history-incremental-search-backward
# [Space] - don't do history expansion
bindkey ' ' magic-space
