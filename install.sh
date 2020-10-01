#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein
currentVersion="1.23.0"
declare -a tools=(bak2dvd bash-snippets cheat cloudup crypt cryptocurrency currency geo gist lyrics meme movies newton pwned qrify short siteciphers stocks taste todo transfer weather ytview)
declare -a extraLinuxTools=(maps)
declare -a extraDarwinTools
usedGithubInstallMethod="0"
prefix="/usr/local"

askInstall()
{
  read -p "Do you wish to install $1 [Y/n]: " answer
  answer=${answer:-Y}

  if [[ "$answer" == [Yy] ]]; then
    cd "$1" || return 1
    echo -n "Installing $1: "
    chmod a+x "$1"
    cp "$1" /usr/local/bin > /dev/null 2>&1 || { echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }
    echo "Success"
    cd .. || return 1
  fi
}

updateTool()
{
  if [[ -f  /usr/local/bin/$1 ]]; then
    usedGithubInstallMethod="1"
    cd "$1" || return 1
    echo -n "Installing $1: "
    chmod a+x "$1"
    cp "$1" /usr/local/bin > /dev/null 2>&1 || { echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }
    echo "Success"
    cd .. || return 1
  fi
}

extraUpdateTool()
{
  if [[ -f  /usr/local/bin/$1 ]]; then
    usedGithubInstallMethod="1"
    cd extras || return 1
    cd "$2" || return 1
    cd "$1" || return 1
    echo -n "Installing $1: "
    chmod a+x "$1"
    cp "$1" /usr/local/bin > /dev/null 2>&1 || { echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }
    echo "Success"
    cd .. || return 1
    cd .. || return 1
    cd .. || return 1
  fi
}

singleInstall()
{
  cd "$1" || exit 1
  echo -n "Installing $1: "
  chmod a+x "$1"
  cp "$1" $prefix/bin > /dev/null 2>&1 || { echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }
  echo "Success"
  cd .. || exit 1
}

copyManpage()
{
  manPath="$prefix/share/man/man1"
  if [ -f "$prefix/man/man1/bash-snippets.1" ]; then rm -f "$prefix/man/man1/bash-snippets.1"; fi
  cp bash-snippets.1 $manPath 2>&1 || { echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }
}

response=$( echo "$@" | grep -Eo "\-\-prefix")

if [[ $response == "--prefix" ]]; then
  prefix=$(echo -n "$@" | sed -e 's/--prefix=\(.*\) .*/\1/' | cut -d " " -f 1)
  mkdir -p "$prefix"/bin "$prefix"/share/man/man1
  if [[ $2 == "all" ]];then
    for tool in "${tools[@]}"; do
      singleInstall "$tool" || exit 1
    done
  else
    for tool in "${@:2}"; do
      singleInstall "$tool" || exit 1
    done
  fi
  copyManpage || exit 1
elif [[ $# == 0 ]]; then
  for tool in "${tools[@]}"; do
    askInstall "$tool" || exit 1
  done
  copyManpage || exit 1
elif [[ $1 == "update" ]]; then
  echo "Updating scripts..."
  for tool in "${tools[@]}"; do
    updateTool "$tool" || exit 1
  done
  if [[ $(uname -s) == "Linux" ]]; then
    for tool in "${extraLinuxTools[@]}"; do
      extraUpdateTool "$tool" Linux || exit 1
    done
  fi
  if [[ $(uname) == "Darwin" ]];then
    for tool in "${extraDarwinTools[@]}"; do
      extraUpdateTool "$tool" Darwin || exit 1
    done
  fi
  if [[ $usedGithubInstallMethod == "1" ]]; then
    copyManpage || exit 1
  else
    echo "It appears you have installed bash-snippets through a package manager, you must update it with the respective package manager."
    exit 1
  fi
elif [[ $1 == "all" ]]; then
  for tool in "${tools[@]}"; do
    singleInstall "$tool" || exit 1
  done
  copyManpage || exit 1
else
  singleInstall "$1" || exit 1
  copyManpage || exit 1
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
