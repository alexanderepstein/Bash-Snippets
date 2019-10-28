#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein
currentVersion="1.23.0"
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
    echo "Error: This tool requires either curl, wget, httpie or fetch to be installed." >&2
    return 1
  fi
}

# The python and JSON functions can be deleted if the script does not need them

## This function determines which version of python is installed on the machine
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

## Don't alter the python call if it's coming from a Mac
if [[ $(uname) != "Darwin" ]]; then
  python()
  {
    case "$configuredPython" in
      python3) python3 "$@" ;;
      python2) python2 "$@" ;;
      python)  python "$@" ;;
    esac
  }
fi

## Grabs an element from a a json string and then echoes it to stdout
## $1 = the JSON string
## $n+1 = the elements to be indexed
AccessJsonElement() {
  json="$1"
  shift
  accessor=""
  for element in "$@"; do
      accessor="${accessor}['$element']"
  done
  echo "$json" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)${accessor})"
  return "$?"
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
  # Update utility version 1.2.0
  # To test the tool enter in the default values that are in the examples for each variable
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
        git clone "https://github.com/$githubUserName/$repositoryName" || { echo "Couldn't download latest version"; exit 1; }
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

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

usage()
{
  cat <<EOF
Skeleton
Description: Short desciption of the tool.
Usage: tool [flags] or tool [flags] [arguments]
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Examples:
   tool
   tool
EOF
}



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
    u)  getConfiguredClient || exit 1
        checkInternet || exit 1
        update
        exit 0
        ;;
    :)  echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done

# special set of first arguments that have a specific behavior across tools
if [[ $# == "0" ]]; then
  usage ## if calling the tool with no flags and args chances are you want to return usage
  exit 0
elif [[ $# == "1" ]]; then
  if [[ $1 == "update" ]]; then
    getConfiguredClient || exit 1
    checkInternet || exit 1
    update || exit 1
    exit 0
  elif [[ $1 == "help" ]]; then
    usage
    exit 0
  fi
fi

## The rest of the conditions and code would go here
## Make sure to use checkInternet at least once before any time httpGet will be called.
## Make sure to call getConfiguredClient at least once before ever calling checkInternet.
## Make sure to call getConfiguredPython at least once before trying to pipeout to python directly or using AccessJsonElement