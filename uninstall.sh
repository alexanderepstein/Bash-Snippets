#!/bin/bash
# Author: Alexander Epstein https://github.com/alexanderepstein

if [[ -f  /usr/local/bin/currency ]];then
  echo -n "Do you wish to uninstall currency [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd currency || exit 1
    ./uninstall.sh || exit 1
    cd .. || exit 1
  fi
  unset answer
fi

if [[ -f  /usr/local/bin/stocks ]];then
  echo -n "Do you wish to uninstall stocks [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd stocks || exit 1
    ./uninstall.sh
    cd .. || exit 1

  fi
  unset answer
fi

if [[ -f  /usr/local/bin/weather ]];then
  echo -n "Do you wish to uninstall weather [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd weather || exit 1
    ./uninstall.sh
    cd .. || exit 1

  fi
  unset answer
fi

if [[ -f  /usr/local/bin/crypt ]];then
  echo -n "Do you wish to uninstall crypt [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd crypt || exit 1
    ./uninstall.sh
    cd .. || exit 1

  fi
  unset answer
fi

if [[ -f  /usr/local/bin/movies ]];then
  echo -n "Do you wish to uninstall movies [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd movies || exit 1
    ./uninstall.sh
    cd .. || exit 1
  fi
fi

if [[ -f  /usr/local/bin/taste ]];then
  echo -n "Do you wish to uninstall taste [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd taste || exit 1
    ./uninstall.sh
    cd .. || exit 1
  fi
fi

if [[ -f  /usr/local/bin/short ]];then
  echo -n "Do you wish to uninstall short [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd short || exit 1
    ./uninstall.sh
    cd .. || exit 1
  fi
fi

if [[ -f  /usr/local/bin/geo ]];then
  echo -n "Do you wish to uninstall geo [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd geo || exit 1
    ./uninstall.sh
    cd .. || exit 1
  fi
fi

if [[ -f  /usr/local/bin/cheat ]];then
  echo -n "Do you wish to uninstall cheat [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd cheat || exit 1
    ./uninstall.sh
    cd .. || exit 1
  fi
fi

if [[ -f  /usr/local/bin/ytview ]];then
  echo -n "Do you wish to uninstall ytview [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd ytview || exit 1
    ./uninstall.sh
    cd .. || exit 1
  fi
fi

if [[ -f  /usr/local/bin/cloudup ]];then
  echo -n "Do you wish to uninstall cloudup [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd cloudup || exit 1
    ./uninstall.sh
    cd .. || exit 1
  fi
fi
