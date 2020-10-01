#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein

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

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
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
Short
Description: Shorten urls and unmask shortended urls.
Usage: short [flag] [URL] or short [flag]
  -s  Shorten the URL
  -e  Expand a shortened URL
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Example:
   Input:  short tinyurl.com/jhkj
   Output: http://possiblemaliciouswebsiteornot.com
EOF
}

expandURL()
{
  testURL=$( echo "$1" | cut -c1-8 )
  if [[ $testURL != "https://" ]]; then
    testURL=$( echo "$1" | cut -c1-7 )
    if [[ $testURL != "http://" ]]; then
      url="http://$1"
    else
      url=$1
    fi
  else
    url=$1
  fi
  response=$(httpGet https://unshorten.me/s/"$url")
  errorCheck=$(echo "$response")
  if [[ $errorCheck == "Invalid Short URL" ]]; then
  echo "Error: 404 could not find the website"
  return 1
fi
  returnedURL=$(echo "$response")
}

shortenURL()
{
newURL=$1
if [[ $(echo "$1" | grep -Eo "^[h]ttp[s]?://") == "" ]]; then newURL="http://"$1; fi
response=$(httpGet http://tinyurl.com/api-create.php?url="$newURL")
returnedURL=$(echo "$response")
}

printResults()
{
  cat <<EOF
=====================================================================
Short URL:    $inputURL
Expanded URL: $returnedURL
=====================================================================
EOF
}

printShortenedResults()
{
  cat <<EOF
=====================================================================
Original URL:  $newURL
Shortened URL: $returnedURL
=====================================================================
EOF
}

getConfiguredClient || exit 1


while getopts "e:s:uvh" opt; do
  case "$opt" in
    \?) echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    e)
        expand="true"
        inputURL=$OPTARG
        ;;
    s)
        shorten="true"
        inputURL=$OPTARG
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

if  [[ $expand == "true" && $shorten == "true" ]];then
  echo "Error: the -e and the -s options are mutually exclusive" >&2
  exit 1
fi

if [[ $# == 0 ]]; then
  usage
  exit 0
elif [[ $# == "1" ]]; then
  if [[ $1 == "update" ]]; then
    checkInternet || exit 1
    update
  elif [[ $1 == "help" ]]; then
    usage

  else
    usage
    exit 1
  fi
elif [[ $expand == "true" ]];then
  checkInternet || exit 1
  expandURL "$inputURL" || exit 1
  printResults
elif [[ $shorten == "true" ]];then
  if [[ $configuredClient != "curl" ]];then
    echo "Error: to shorten URLS you must have curl installed"
  fi
  checkInternet || exit 1
  shortenURL "$inputURL"
  printShortenedResults
else
  echo "Error: short only accepts one argument"
  exit 1
fi
