#!/usr/bin/env zsh

main()
{
    local DATE=$(date +%Y-%m-%d)
    local ID=$(date +%s)
    local NEW_ZSHRC=".zshrc_${DATE}_${ID}"
    local ZSH_RON_DIR="$HOME/.local/share/zsh-ron"
    local ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"

    # check if ZSH_RON_DIR already exists
    if [[ -d "$ZSH_RON_DIR" ]]; then
        echo "zsh-ron is already installed in '$ZSH_RON_DIR'"
        read -q "res?Reinstall zsh-ron (To update zsh-ron run 'zshr update')? [y/N] "
        echo ""
        [[ $res == "n" ]] && {
            echo "skipped"
            return
        }
        echo "Reinstalling zsh-ron..."
        rm -rf "$ZSH_RON_DIR"
    else
        echo "Installing zsh-ron..."
    fi

    git clone https://github.com/volkarts-dev/zsh-ron.git "$ZSH_RON_DIR" \
        --recurse-submodules --shallow-submodules > /dev/null 2>&1

    # Check if the current .zshrc file exists
    if [ -f "$ZSHRC" ]; then
        # Move the current .zshrc file to the new filename
        mv "$ZSHRC" "$HOME/$NEW_ZSHRC"
        echo "Moved .zshrc to $NEW_ZSHRC"
    else
        echo "No .zshrc file found, creating a new one..."
    fi

    cat >"$ZSHRC" <<EOF
# Created by Ron's zsh-ron installer

[ -f "$HOME/.local/share/zsh-ron/zsh-ron.zsh" ] && source "$HOME/.local/share/zsh-ron/zsh-ron.zsh"
EOF

    echo "Installed - Restart zsh to apply changes"

    return 0
}

main $@
