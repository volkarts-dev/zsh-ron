#!/usr/bin/env zsh

main() {

    local DATE=$(date +%Y-%m-%d)
    local ID=$(date +%s)
    local NEW_ZSHRC=".zshrc_${DATE}_${ID}"
    local ZAP_DIR="$HOME/.local/share/zap"
    local ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"
    local BRANCH="release-v1"

    # Check if the current .zshrc file exists
    if [ -f "$ZSHRC" ]; then
        # Move the current .zshrc file to the new filename
        mv "$ZSHRC" "$HOME/$NEW_ZSHRC"
        echo "Moved .zshrc to $NEW_ZSHRC"
    else
        echo "No .zshrc file found, creating a new one..."
    fi

    # Check if .zshrc file exists, create it if not
    if [ ! -f "$ZSHRC" ]; then
        touch "$ZSHRC"
    fi


    cat >"$ZSHRC" <<EOF
# Created by Ron's Zap installer

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions" "v0.7.0"
plug "zsh-users/zsh-syntax-highlighting" "754cefe0181a7acd42fdcb357a67d0217291ac47"
plug "zap-zsh/supercharge" "979d4cbbd53435f5dda65ebfd324d7ad80987ad4"
plug "zap-zsh/sudo" "b3e86492d6d48c669902b9fb5699a75894cfcebc"

plug "DerSauron/zsh-ron"

plug "romkatv/powerlevel10k" "v1.18.0"
EOF

    # check if ZAP_DIR already exists
    [[ -d "$ZAP_DIR" ]] && {
        echo "Zap is already installed in '$ZAP_DIR'!"
        read -q "res?Reinstall Zap? [y/N] "
        echo ""
        [[ $res == "n" ]] && {
            echo "❕ skipped!"
            return
        }
        echo "Reinstalling Zap..."
        rm -rf "$ZAP_DIR"
    }

    git clone -b "${BRANCH:-master}" https://github.com/zap-zsh/zap.git "$ZAP_DIR" > /dev/null 2>&1 || { echo "❌ Failed to install Zap" && return 2 }

    echo " Zapped"

    return 0
}

main $@

[[ $? -eq 0 ]] && exec zsh || return

# vim: ft=zsh ts=4 et
