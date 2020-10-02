#!/usr/bin/env bash
DELAY=1
configuredClient=""
currentVersion="1.23.0"

checkOpenSSL()
{
  if  ! command -v openssl &>/dev/null; then
    echo "Error: to use this tool openssl must be installed" >&2
    return 1
  else
    return 0
  fi
}

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
    echo "Error: This tool requires either curl, wget, httpie or fetch to be installed." >&2
    return 1
  fi
}

## Allows to call the users configured client without if statements everywhere
httpGet()
{
  case "$configuredClient" in
    curl)  curl -A curl -s "$@" ;;
    wget)  wget -qO- "$@" ;;
    httpie) http -b GET "$@" ;;
    fetch) fetch -q "$@" ;;
  esac
}

update()
{
  # Author: Alexander Epstein https://github.com/alexanderepstein
  # Update utility version 2.2.0
  # To test the tool enter in the defualt values that are in the examples for each variable
  repositoryName="Bash-Snippets" #Name of repostiory to be updated ex. Sandman-Lite
  githubUserName="alexanderepstein" #username that hosts the repostiory ex. alexanderepstein
  nameOfInstallFile="install.sh" # change this if the installer file has a different name be sure to include file extension if there is one
  latestVersion=$(httpGet https://api.github.com/repos/$githubUserName/$repositoryName/tags | grep -Eo '"name":.*?[^\\]",'| head -1 | grep -Eo "[0-9.]+" ) #always grabs the tag without the v option

  if [[ $currentVersion == "" || $repositoryName == "" || $githubUserName == "" || $nameOfInstallFile == "" ]]; then
    echo "Error: update utility has not been configured correctly." >&2
    exit 1
  elif [[ $latestVersion == "" ]]; then
    echo "Error: no active internet connection" >&2
    exit 1
  else
    if [[ "$latestVersion" != "$currentVersion" ]]; then
      echo "Version $latestVersion available"
      echo -n "Do you wish to update $repositoryName [Y/n]: "
      read -r answer
      if [[ "$answer" == [Yy] ]]; then
        cd ~ || { echo 'Update Failed'; exit 1; }
        if [[ -d  ~/$repositoryName ]]; then rm -r -f $repositoryName || { echo "Permissions Error: try running the update as sudo"; exit 1; } ; fi
        echo -n "Downloading latest version of: $repositoryName."
        git clone -q "https://github.com/$githubUserName/$repositoryName" && touch .BSnippetsHiddenFile || { echo "Failure!"; exit 1; } &
        while [ ! -f .BSnippetsHiddenFile ]; do { echo -n "."; sleep 2; };done
        rm -f .BSnippetsHiddenFile
        echo "Success!"
        cd $repositoryName || { echo 'Update Failed'; exit 1; }
        git checkout "v$latestVersion" 2> /dev/null || git checkout "$latestVersion" 2> /dev/null || echo "Couldn't git checkout to stable release, updating to latest commit."
        chmod a+x install.sh #this might be necessary in your case but wasnt in mine.
        ./$nameOfInstallFile "update" || exit 1
        cd ..
        rm -r -f $repositoryName || { echo "Permissions Error: update succesfull but cannot delete temp files located at ~/$repositoryName delete this directory with sudo"; exit 1; }
      else
        exit 1
      fi
    else
      echo "$repositoryName is already the latest version"
    fi
  fi
}

usage()
{
  cat <<EOF
Siteciphers
Description: Checks the available ciphers for the SSL of an https site.
Usage: siteciphers [flag] or siteciphers [optionalDFlag] [website]
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
  -d  Set the delay between requests sent to the site (default is 1 sec)
Examples:
  siteciphers github.com
  siteciphers -d 0.5 github.com
EOF
}

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

checkCiphers()
{
  ciphers=$(openssl ciphers 'ALL:eNULL' | sed -e 's/:/ /g') # grab all ciphers
  SERVER=$1:443 # setup the connection server
  for cipher in ${ciphers[*]}; do # for all possible ciphers
    result=$(echo | openssl s_client -cipher "$cipher" -connect "$SERVER" 2>&1)
    if [[ "$result" =~ ":error:" ]]; then
      if [[ -z $2 ]]; then
        error=$(echo -n "$result" | cut -d':' -f6)
        echo "$cipher - NO ($error)"
      fi
    else
      if [[ "$result" =~ "Cipher is $cipher" || "$result" =~ "Cipher    :" ]]; then
        echo "$cipher - YES"
      else
        if [[ -z $2 ]]; then
          echo "$cipher - UNKNOWN RESPONSE - $result"
        fi
      fi
    fi
    sleep $DELAY # sleep as to not overload the requests to the server
  done
}

checkOpenSSL || exit 1
getConfiguredClient || exit 1


if [[ $# == "0" ]]; then
  usage
  exit 1
elif [[ $1 == "update" ]]; then
  checkInternet || exit 1
  update
  exit 0
elif [[ $1 == "help" ]]; then
  usage
  exit 0
fi

while getopts "huvd:" opt; do ## alows for using options in bash
  case "$opt" in
    \?) echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    d)  #set the delay with the -d option
        DELAY=$OPTARG
        dFlag="1"
        ;;
    u)  checkInternet || exit 1
        update
        exit 0
        ;;
    h)  usage
        exit 0
        ;;
    v)  echo "Version $currentVersion"
        exit 0
        ;;
    :)  ## will run when no arguments are provided to to d options
        echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done

checkInternet || exit 1
if [[ $dFlag == "1" ]]; then
  checkCiphers "$3" || exit 1 # if dflag is present input will look like siteciphers -d 0.5 github.com making the website the third arg
else
  checkCiphers "$1" || exit 1
fi
