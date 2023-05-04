#!/usr/bin/zsh

# ron's plugin
# all that's needed for using zsh

# requires
# -

() {
    local dir="${${(%):-%x}:a:h}"

    source "${dir}/fixes.zsh"
    source "${dir}/key-bindings.zsh"
    source "${dir}/supercharge.zsh"

    source "${dir}/p10k-config.zsh"
}
