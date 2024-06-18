autoload -U add-zsh-hook

function _make_cache_file()
{
    echo "${zr_cache_dir}/last-working-dir${SSH_USER:+.$SSH_USER}"
}

function _chpwd_last_working_dir()
{
    [[ $ZSH_SUBSHELL -eq 0 ]] || return 0

    local cache_file="$(_make_cache_file)"
    builtin pwd >| "${cache_file}"
}

add-zsh-hook chpwd _chpwd_last_working_dir

function lwd()
{
    local cache_file="$(_make_cache_file)"
    [[ -r "${cache_file}" ]] && cd "$(cat "${cache_file}")"
}

function show_lwd()
{
    local cache_file="$(_make_cache_file)"
    [[ -r "${cache_file}" ]] && cat "${cache_file}"
}
