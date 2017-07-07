#!/bin/bash
# Author: Alexander Epstein https://github.com/alexanderepstein

askUninstall()
{
  if [[ -f  /usr/local/bin/$1 ]];then
    echo -n "Do you wish to uninstall $1 [Y/n]: "
    read -r answer
    if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
      cd $1 || return 1
      ./uninstall.sh || return 1
      cd .. || return 1
    fi
    unset answer
  fi
}


askUninstall currency || exit 1
askUninstall stocks || exit 1
askUninstall weather || exit 1
askUninstall crypt || exit 1
askUninstall movies || exit 1
askUninstall taste || exit 1
askUninstall short || exit 1
askUninstall geo || exit 1
askUninstall cheat || exit 1
askUninstall ytview || exit 1
askUninstall cloudup || exit 1
askUninstall qrify || exit 1
