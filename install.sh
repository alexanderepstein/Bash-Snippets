#!/bin/bash
# Author: Alexander Epstein https://github.com/alexanderepstein
currentVersion="1.10.1"
declare -a tools=(currency stocks weather crypt movies taste short geo cheat ytview cloudup qrify)

askInstall()
{
  echo -n "Do you wish to install $1 [Y/n]: "
  read -r answer
  if [[ "$answer" == "Y" || "$answer" == "y" ]] ;then
    cd $1 || return 1
    chmod a+x install.sh || return 1
    ./install.sh || return 1
    cd .. || return 1
  fi
}

updateTool()
{
  if [[ -f  /usr/local/bin/$1 ]];then
    cd $1 || return 1
    chmod a+x install.sh || return 1
    ./install.sh || return 1
    cd .. || return 1
  fi
}
singleInstall()
{
  cd $1 || exit 1
  chmod a+x install.sh || return 1
  ./install.sh || exit 1
  cd .. || exit 1
}

if [[ $# == 0 ]]; then
  for tool in "${tools[@]}"
  do
    askInstall $tool || exit 1
  done
elif [[ $1 == "update" ]]; then
  echo "Updating scripts..."
  for tool in "${tools[@]}"
  do
    updateTool $tool || exit 1
  done
elif [[ $1 == "all" ]];then
  for tool in "${tools[@]}"
  do
    singleInstall $tool || exit 1
  done
else
  singleInstall $1 || exit 1
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
