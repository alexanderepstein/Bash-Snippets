#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein
declare -a tools=(bak2dvd bash-snippets cheat cloudup crypt cryptocurrency currency geo gist lyrics meme movies newton pwned qrify short siteciphers stocks taste todo transfer weather ytview)
all="1"

askUninstall()
{
  if [[ -f /usr/local/bin/$1 ]]; then
    echo -n "Do you wish to uninstall $1 [Y/n]: "
    read -r answer
    if [[ "$answer" == [Yy] ]]; then
      echo -n "Removing $1: "
      rm -f /usr/local/bin/"$1" > /dev/null 2>&1 || { echo "Failed" ; echo "Error removing file, try running uninstall script as sudo"; exit 1; }
      echo "Success"
    else
      all="0"
    fi
    unset answer
  fi
}

removeTool()
{
  if [[ -f /usr/local/bin/$1 ]]; then
    echo -n "Removing $1: "
    rm -f /usr/local/bin/"$1" > /dev/null 2>&1 || { echo "Failed" ; echo "Error removing file, try running uninstall script as sudo"; exit 1; }
    echo "Success"
  fi
}

removeManpage()
{
  if [ -f "/usr/local/man/man1/bash-snippets.1" ]; then rm -f "usr/local/man/man1/bash-snippets.1" || { echo "Error removing manpage, try running uninstall script as sudo"; exit 1; } ; fi
  if [ -f "/usr/local/share/man/man1/bash-snippets.1" ]; then rm -f "/usr/local/share/man/man1/bash-snippets.1" || { echo "Error removing manpage, try running uninstall script as sudo"; exit 1; } ; fi
}

if [[ $1 != "all" ]]; then
  for tool in "${tools[@]}"; do
    askUninstall "$tool" || exit 1
  done
else
  for tool in "${tools[@]}"; do
    removeTool "$tool" || exit 1
  done
fi

if [[ $all == "1" ]]; then
  removeManpage || exit 1
fi
