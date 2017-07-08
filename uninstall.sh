#!/bin/bash
# Author: Alexander Epstein https://github.com/alexanderepstein
declare -a tools=(currency stocks weather crypt movies taste short geo cheat ytview cloudup qrify)
all="1"

askUninstall()
{
  if [[ -f  /usr/local/bin/$1 ]];then
    echo -n "Do you wish to uninstall $1 [Y/n]: "
    read -r answer
    if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
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

for tool in "${tools[@]}"
do
  askUninstall $tool || exit 1
done

if [[ $all == "1" ]];then removeManpage || exit 1;fi
