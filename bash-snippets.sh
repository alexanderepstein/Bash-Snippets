#!/bin/env bash
# Author: Navan Chauhan and Alexander Epstein
currentVersion="1.21.0"
configuredClient=""

## This function determines which http get tool the system has installed and returns an error if there isnt one
getConfiguredClient()
{
  if  command -v curl &>/dev/null; then
    configuredClient="curl"
  elif command -v wget &>/dev/null; then
    configuredClient="wget"
  elif command -v http &>/dev/null; then
    configuredClient="httpie"
  elif command -v fetch &>/dev/null; then
    configuredClient="fetch"
  else
    echo "Error: This tool reqires either curl, wget, httpie or fetch to be installed." >&2
    return 1
  fi
}

httpGet()
{
  case "$configuredClient" in
    curl)  curl -A curl -s "$@" ;;
    wget)  wget -qO- "$@" ;;
    httpie) http -b GET "$@" ;;
    fetch) fetch -q "$@" ;;
  esac
}

grablatestversion()
{
    repositoryName="Bash-Snippets"
  githubUserName="alexanderepstein"
  latestVersion=$(httpGet https://api.github.com/repos/$githubUserName/$repositoryName/tags | grep -Eo '"name":.*?[^\\]",'| head -1 | grep -Eo "[0-9.]+" ) #always grabs the tag without the v option

}

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

header(){
  COLUMNS=$(tput cols)
  title="Bash Snippets"
  installver="Installed Version : $currentVersion"
  latestver="Latest Version    : $latestVersion"
  printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
  printf "%*s\n" $(((${#installver}+$COLUMNS)/2)) "$installver"
  printf "%*s\n" $(((${#latestver}+$COLUMNS)/2)) "$latestver"

}

installationcheck(){
cd /usr/local/bin
  for f in cheat cloudup crypt cryptocurrency currency geo lyrics meme movies newton qrify short siteciphers stocks taste todo transfer weather ytview
    do
      if [ -e $f ]
        then
          echo "$f is Installed"
        else
          echo "$f is Not Installed"
        fi
    done

}

checkInternet
getConfiguredClient
grablatestversion
header
installationcheck
