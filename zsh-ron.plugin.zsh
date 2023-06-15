#!/usr/bin/zsh

# ron's plugin
# all that's needed for using zsh

# requires
# -

function setup_paths()
{
    zr_plugin_dir="${${(%):-%x}:a:h}"

    local plugin_name="${zr_plugin_dir:t}"

    zr_cache_dir="$HOME/.cache/zsh-plugins/${plugin_name}"

    [[ -d "${zr_cache_dir}" ]] || mkdir -p "${zr_cache_dir}"
}

() {
    setup_paths

    source "${zr_plugin_dir}/fixes.zsh"
    source "${zr_plugin_dir}/key-bindings.zsh"
    source "${zr_plugin_dir}/supercharge.zsh"
    source "${zr_plugin_dir}/last-dir.zsh"
    source "${zr_plugin_dir}/command-not-found.zsh"

    source "${zr_plugin_dir}/p10k-config.zsh"
}
