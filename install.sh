#!/bin/bash
# Author: Alexander Epstein https://github.com/alexanderepstein
currentVersion="1.10.0"

if [[ $# == 0 ]]; then

  echo -n "Do you wish to install currency [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd currency || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi

  unset answer
  echo -n "Do you wish to install stocks [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd stocks || exit 1
    ./install.sh
    cd .. || exit 1

  fi

  unset answer
  echo -n "Do you wish to install weather [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd weather || exit 1
    ./install.sh
    cd .. || exit 1

  fi

  unset answer
  echo -n "Do you wish to install crypt [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd crypt || exit 1
    ./install.sh
    cd .. || exit 1

  fi

  unset answer
  echo -n "Do you wish to install movies [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd movies || exit 1
    ./install.sh
    cd .. || exit 1
  fi

  unset answer
  echo -n "Do you wish to install taste [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd taste || exit 1
    ./install.sh
    cd .. || exit 1
  fi

  unset answer
  echo -n "Do you wish to install short [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd short || exit 1
    ./install.sh
    cd .. || exit 1
  fi

  unset answer
  echo -n "Do you wish to install geo [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd geo || exit 1
    ./install.sh
    cd .. || exit 1
  fi

  unset answer
  echo -n "Do you wish to install cheat [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd cheat || exit 1
    ./install.sh
    cd .. || exit 1
  fi

  unset answer
  echo -n "Do you wish to install ytview [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd ytview || exit 1
    ./install.sh
    cd .. || exit 1
  fi

  unset answer
  echo -n "Do you wish to install cloudup [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd cloudup || exit 1
    ./install.sh
    cd .. || exit 1
  fi

  unset answer
  echo -n "Do you wish to install qrify [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd qrify || exit 1
    ./install.sh
    cd .. || exit 1
  fi

fi

if [[ $1  == "currency" ]];then
  cd currency || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "stocks" ]]; then
  cd stocks || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "weather" ]]; then
  cd weather || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "crypt" ]]; then
  cd crypt || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "movies" ]]; then
  cd movies || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "taste" ]]; then
  cd taste || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "short" ]]; then
  cd short || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "geo" ]]; then
  cd geo || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "cheat" ]]; then
  cd cheat || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "ytview" ]]; then
  cd ytview || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "cloudup" ]]; then
  cd cloudup || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "qrify" ]]; then
  cd qrify || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "all" ]];then
  cd currency || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
  cd stocks || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
  cd weather || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
  cd crypt || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
  cd movies || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
  cd taste || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
  cd short || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
  cd geo || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
  cd cheat || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
  cd ytview || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
  cd cloudup || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
  cd qrify || exit 1
  ./install.sh || exit 1
  cd .. || exit 1
elif [[ $1 == "update" ]]; then
  echo "Updating scripts..."
  if [[ -f  /usr/local/bin/currency ]];then
    cd currency || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
  if [[ -f  /usr/local/bin/stocks ]];then
    cd stocks || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
  if [[ -f  /usr/local/bin/weather ]];then
    cd weather || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
  if [[ -f  /usr/local/bin/crypt ]];then
    cd crypt || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
  if [[ -f  /usr/local/bin/movies ]];then
    cd movies || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
  if [[ -f  /usr/local/bin/taste ]];then
    cd taste || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
  if [[ -f  /usr/local/bin/short ]];then
    cd short || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
  if [[ -f  /usr/local/bin/geo ]];then
    cd geo || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
  if [[ -f  /usr/local/bin/cheat ]];then
    cd cheat || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
  if [[ -f  /usr/local/bin/ytview ]];then
    cd ytview || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
  if [[ -f  /usr/local/bin/cloudup ]];then
    cd cloudup || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
  if [[ -f  /usr/local/bin/qrify ]];then
    cd qrify || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
fi

echo -n "( •_•)"
sleep .75
echo -n -e "\r( •_•)>⌐■-■"
sleep .75
echo -n -e "\r               "
echo  -e "\r(⌐■_■)"
sleep .5
echo "Bash Snippets version $currentVersion"
echo  "https://github.com/alexanderepstein/Bash-Snippets"
