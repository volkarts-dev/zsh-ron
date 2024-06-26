() {
    local user_path="$HOME/.local/share/zsh-ron.d"

    for file in $user_path/*.zsh; do
        source $file
    done

    echo "Test"
}
