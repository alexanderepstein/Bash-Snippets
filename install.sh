#!/bin/bash
# Author: Alexander Epstein https://github.com/alexanderepstein
currentVersion="1.10.1"

askInstall()
{
  echo -n "Do you wish to install $1 [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd $1 || return 1
    ./install.sh || return 1
    cd .. || return 1
  fi
}

updateTool()
{
  if [[ -f  /usr/local/bin/$1 ]];then
    cd $1 || exit 1
    ./install.sh || exit 1
    cd .. || exit 1
  fi
}

if [[ $# == 0 ]]; then

  askInstall currency || exit 1
  askInstall stocks || exit 1
  askInstall weather || exit 1
  askInstall crypt || exit 1
  askInstall movies || exit 1
  askInstall taste || exit 1
  askInstall short || exit 1
  askInstall geo || exit 1
  askInstall cheat || exit 1
  askInstall ytview || exit 1
  askInstall cloudup || exit 1
  askInstall qrify || exit 1
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
  updateTool currency
  updateTool stocks
  updateTool weather
  updateTool crypt
  updateTool movies
  updateTool taste
  updateTool short
  updateTool geo
  updateTool cheat
  updateTool ytview
  updateTool cloudup
  updateTool qrify
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
