#!/usr/bin/zsh

# include command not found functionality if installed
# this works on debian and ubuntu
if [ -e /etc/zsh_command_not_found ]; then
    source /etc/zsh_command_not_found
fi
