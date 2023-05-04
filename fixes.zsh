#!/usr/bin/zsh

# Explicitly enable bracketed paste magic
set zle_bracketed_paste
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
