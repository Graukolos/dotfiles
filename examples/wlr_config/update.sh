#!/bin/sh

set -euo pipefail

CONFIG=$HOME/.config
SOURCE=""

# Confirmation prompt
prompt () {
  echo -e "Do you want to $1 $2 (y/n)"
  read ans
}

# Update configuration files
for config in $(ls -A ./)
do
  if [[ "$@" =~ $config ]]; then
    :
  elif [ -d $HOME/.mozilla/firefox/*.default-release/$config ]; then
    SOURCE=$HOME/.mozilla/firefox/*.default-release/$config
    echo "$config copied from $SOURCE"
  elif [[ -d "$CONFIG/$config" || -f "$CONFIG/$config" ]]; then
    SOURCE="$CONFIG/$config"
    echo "$config copied from $SOURCE"
  elif [[ -d "$HOME/$config" || -f "$HOME/$config" ]]; then
    SOURCE="$CONFIG/$config"
    echo "$config copied from $SOURCE"
  fi
  if [ -d $SOURCE ]; then
    cp -rf $SOURCE ./
  else
    cp $SOURCE ./
  fi
done

# Success message
echo ""
echo "Update finished!"
