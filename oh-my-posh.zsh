#!/usr/bin/zsh

if ! command -v oh-my-posh &> /dev/null; then
  echo "oh-my-posh is not installed. Cannot configure prompt."
else
  eval "$(oh-my-posh init zsh --config=${zr_plugin_dir}/ron-zsh.omp.json)"
fi
