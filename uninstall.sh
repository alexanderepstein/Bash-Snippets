#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein
declare -a tools=(cheat cloudup crypt cryptocurrency currency geo movies newton qrify short siteciphers stocks taste todo weather ytview)
all="1"

askUninstall()
{
  if [[ -f  /usr/local/bin/$1 ]]; then
    echo -n "Do you wish to uninstall $1 [Y/n]: "
    read -r answer
    if [[ "$answer" == [Yy] ]]; then
      cd $1 || return 1
      echo -n "Removing $1: "
      rm -f /usr/local/bin/$1 > /dev/null 2>&1 || { echo "Failed" ; echo "Error removing file, try running uninstall script as sudo"; exit 1; }
      echo "Success"
      cd .. || return 1
    else
      all="0"
    fi
    unset answer
  fi
}

removeManpage()
{
  rm -f /usr/local/man/man1/bash-snippets.1 2>&1 || { echo "Failed" ; echo "Error removing file, try running uninstall script as sudo"; exit 1; }
}

for tool in "${tools[@]}"; do
  askUninstall $tool || exit 1
done

if [[ $all == "1" ]]; then
  removeManpage || exit 1
fi
