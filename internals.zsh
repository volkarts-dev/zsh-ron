# internal zshr command

function _zshr_update()
{
    local zsh_ron_dir="${0:A:h}"

    (
        cd "${zsh_ron_dir}"

        echo "Update zsh-ron..."

        git fetch origin >/dev/null
        if [ $? -ne 0 ]; then
            echo "Failed to update zsh-ron" >&2
            exit 1
        fi

        git merge origin/main >/dev/null
        if [ $? -ne 0 ]; then
            echo "Failed to update zsh-ron" >&2
            exit 1
        fi

        git submodule update --init >/dev/null
        if [ $? -ne 0 ]; then
            echo "Failed to update zsh-ron" >&2
            exit 1
        fi

        echo "Successfully updated"
    )
}

function _zshr_help()
{
    echo "zsh-ron - Help

Usage: zshr <command>

COMMANDS:
    help      Show this help message
    update    Update zsh-ron"
}

function zshr()
{
    typeset -A subcmds=(
        help "_zshr_help"
        update "_zshr_update"
    )
    emulate -L zsh
    [[ -z "$subcmds[$1]" ]] && { _zshr_help; return 1 } || ${subcmds[$1]} $2
}
