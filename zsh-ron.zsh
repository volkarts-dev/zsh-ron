# ron's plugin
# all that's needed for using zsh

function setup_paths()
{
    zr_plugin_dir="${${(%):-%x}:a:h}"

    local plugin_name="${zr_plugin_dir:t}"

    zr_cache_dir="$HOME/.cache/zsh-plugins/${plugin_name}"

    [[ -d "${zr_cache_dir}" ]] || mkdir -p "${zr_cache_dir}"
}

() {
    setup_paths

    source "${zr_plugin_dir}/extern/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
    source "${zr_plugin_dir}/extern/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
    source "${zr_plugin_dir}/extern/powerlevel10k/powerlevel10k.zsh-theme"

    source "${zr_plugin_dir}/fixes.zsh"
    source "${zr_plugin_dir}/key-bindings.zsh"
    source "${zr_plugin_dir}/supercharge.zsh"
    source "${zr_plugin_dir}/root.zsh"
    source "${zr_plugin_dir}/last-dir.zsh"
    source "${zr_plugin_dir}/internals.zsh"

    source "${zr_plugin_dir}/p10k-config.zsh"

    source "${zr_plugin_dir}/user.zsh"
}
