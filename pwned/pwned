#!/usr/bin/env bash
# Author: Navan Chauhan https://github.com/navanchauhan

currentVersion="1.23.0"
configuredClient=""
configuredPython=""

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

getConfiguredPython()
{
  if command -v python3 &>/dev/null; then
    configuredPython="python3"
  elif  command -v python2 &>/dev/null; then
    configuredPython="python2"
  elif command -v python &>/dev/null; then
    configuredPython="python"
  else
    echo "Error: This tool requires python to be installed."
    return 1
  fi
}

if [[ $(uname) != "Darwin" ]]; then
  python()
  {
    case "$configuredPython" in
      python2) python2 "$@" ;;
      python)  python "$@" ;;
    esac
  }
fi

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

## This function grabs data from Have I been Pwned ? and using python parses it
## JSON response to extrapolate the information for storage
getPwned()
{
	info=$(httpGet  "https://haveibeenpwned.com/api/v2/breachedaccount/$1") > /dev/null #grab the JSON response
  export PYTHONIOENCODING=utf8 #necessary for python in some cases
  echo "$info" | python -c "from __future__ import print_function; import sys, json; print(sys.stdin)[0]['Title'])" > /dev/null 2>&1 || { echo "Looks like you have not been breached"; exit 1; } #
  # The rest of the code is just extrapolating the data with python from the JSON response
  echo "$info" > .pwned.json
  title=$(python -c "from __future__ import print_function; import sys, json; print('\n'.join([u['Title']for u in json.load(open(sys.argv[1]))]))" ".pwned.json")
  rm -f .pwned.json
  unset info # done with the JSON response not needed anymore
}

printPwned()
{
  echo
  echo "============================================="
  echo "$1 has beeen breached at:"
  echo "$title"
  echo "============================================="
  echo
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
pwned
Description: Tells you when your account was last breached
Usage: pwned [flag] or pwned [tag]
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Examples:
  pwned navanchauhan@gmail.com
  pwned navanchauhan@yahoo.com
EOF
}

if [[ $(uname) != "Darwin" ]]; then getConfiguredPython || exit 1; fi
getConfiguredClient || exit 1


while getopts "uvh" opt; do
  case "$opt" in
    \?) echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    h)  usage
        exit 0
        ;;
    v)  echo "Version $currentVersion"
        exit 0
        ;;
    u)  checkInternet || exit 1
        update
        exit 0
        ;;
    :)  echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done

if [[ $1 == "update" ]]; then
  checkInternet || exit 1
  update
  exit 0
elif [[ $1 == "help" ]]; then
  usage
  exit 0
elif [[ $# == "0" ]]; then
  usage
  exit 0
else
  checkInternet || exit 1
  getPwned "$1" # based on the stock symbol exrapolated by the getTicker function get information on the stock
  printPwned "$1"  # print this information out to the user in a human readable format
exit 0
fi
