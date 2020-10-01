#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein

currentVersion="1.23.0"
configuredClient=""
configuredPython=""
source ~/.bash_profile 2> /dev/null ## allows grabbing enviornment variable
apiKey=$TASTE_API_KEY
info="0" ## indicates if we want extra info
search="0" ## indivates that we want results on the item itself

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

## This function gets 3 results similar to the item of interest
getSimilar()
{
  export PYTHONIOENCODING=utf8 #necessary for python in some cases
  media=$( echo "$@" | tr " " + )
  response=$(httpGet "https://tastedive.com/api/similar?q=$media&k=$apiKey&info=$info")
  ## Extrapolate the information by parsing the JSON
  nameOne=$(echo "$response" |python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Results'][0]['Name'])" 2>  /dev/null || { echo "Error: Did you search a valid item?"; return 1; } )
  typeOne=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Results'][0]['Type'])" 2>  /dev/null)
  nameTwo=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Results'][1]['Name'])" 2>  /dev/null)
  typeTwo=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Results'][1]['Type'])" 2>  /dev/null)
  nameThree=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Results'][2]['Name'])" 2>  /dev/null)
  typeThree=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Results'][2]['Type'])" 2>  /dev/null)
  if [[ $info == "1" ]];then ## if we want more detailed info we have to grab a few more fields
    wikiOne=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Results'][0]['wTeaser'])" 2>  /dev/null)
    wikiTwo=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Results'][1]['wTeaser'])" 2>  /dev/null)
    wikiThree=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Results'][2]['wTeaser'])" 2>  /dev/null)
    youtube=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Results'][0]['yUrl'])" 2>  /dev/null)
  fi
}

## This function grabs all the information it can on the item of interest itself
getInfo()
{
  export PYTHONIOENCODING=utf8 #necessary for python in some cases
  media=$( echo "$@" | tr " " + )
  response=$(httpGet "https://tastedive.com/api/similar?q=$media&k=$apiKey&info=$info")
  name=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Info'][0]['Name'])")
  type=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Info'][0]['Type'])")
  if [[ $info == "1" ]]; then
    wiki=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Info'][0]['wTeaser'])")
    youtube=$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['Similar']['Info'][0]['yUrl'])")
  else
    wiki="None"
    youtube="None"
  fi
}

printResults()
{
  if [[ $info == "1" ]];then
    echo "==================================="
    echo
    echo "$nameOne": "$typeOne"
    echo "$wikiOne"
    echo
    echo
    echo "$nameTwo": "$typeTwo"
    echo "$wikiTwo"
    echo
    echo
    echo "$nameThree": "$typeThree"
    echo "$wikiThree"
    echo
    if [[ $youtube != "None" ]]; then echo $youtube; fi
    echo
    echo "==================================="
  else
    echo "==================================="
    echo "$nameOne": "$typeOne"
    echo "$nameTwo": "$typeTwo"
    echo "$nameThree": "$typeThree"
    echo "==================================="
  fi
}

printInfo()
{
  echo "==================================="
  echo
  echo "$name": "$type"
  echo $wiki
  echo
  if [[ $youtube != "None" ]]; then echo $youtube; fi
  echo "==================================="
}

usage()
{
  cat <<EOF
Taste
Description: A recommendation engine that provides 3 similar items based on some input topic.
  Taste also has the ability to provide information on the item of interest.
  Supports: shows, books, music, artists, movies, authors, games
Usage: taste [flag] [item]
  -i  Get more information on similar items
  -s  Get information on the item itself
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Examples:
  taste -i Kendrick Lamar
  taste Catcher in the Rye
  taste -s Red Hot Chili Peppers
EOF
}

if [[ $apiKey == "" ]]; then
  cat <<EOF
Error: API key not setup properly
To get an API key visit https://tastedive.com/account/api_access
After getting the API key run the following command: export TASTE_API_KEY="yourAPIKeyGoesHere"
After following all the steps and issues still persist try adding export TASTE_API_KEY manually to your .bash_profile
EOF
  exit 1
fi
if [[ $(uname) != "Darwin" ]]; then getConfiguredPython || exit 1; fi
getConfiguredClient || exit 1


while getopts "uvhis" opt; do
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
    i)  if [[ $search == "0" ]]; then
          info="1"
        else
          echo "Error: the options -i and -s are mutually exclusive (-s already uses -i)"
          exit 1
        fi
        ;;
    s)  if [[ $info != "1" ]]; then
          search="1"
          info="1"
        else
          echo "Error: the options -i and -s are mutually exclusive (-s already uses -i)"
          exit 1
        fi
        ;;
    :)  echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done

if [[ $# == 0 ]]; then
  usage
elif [[ $1 == "update" ]]; then
  checkInternet || exit 1
  update
elif [[ $1 == "help" ]]; then
  usage
else
  checkInternet || exit 1
  if [[ $search == "0" ]]; then
    if [[ $info == "0" ]]; then
      getSimilar "$@" || exit 1 ## exit if we return 1 (chances are movie was not found)
      printResults
    else
      getSimilar "${@:2}" || exit 1
      printResults
    fi
  else
    getInfo "${@:2}" || exit 1 ## exit if we return 1 (chances are movie was not found)
    printInfo
  fi
fi
