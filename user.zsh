() {
    local user_path="$HOME/.local/share/zsh-ron.d"

    [ -d $user_path ] || return

    for file in $(find "$user_path" -type f -name "*.zsh"); do
        source $file
    done
}
