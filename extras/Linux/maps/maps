#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein

currentVersion="1.23.0"
configuredClient=""
directionsFlag="0"
directionsMapFlag="0"
staticMapFlag="0"
source ~/.bash_profile 2> /dev/null ## allows grabbing enviornment variable
MAPQUEST_API_KEY=$MAPQUEST_API_KEY
if [ -d ~/temp ]; then rm -rf ~/temp; fi

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


getDirections()
{
  response=$(httpGet "https://www.mapquestapi.com/directions/v2/route?key=$MAPQUEST_API_KEY&from=$1&to=$2&outFormat=json&ambiguities=ignore&routeType=fastest&doReverseGeocode=false&enhancedNarrative=false&avoidTimedConditions=false")
  firstDirection=$(echo "$response" | grep -Eo "origNarrative\":\"[a-z A-Z -./0-9]*" | grep -Eo "[^origNarrative\":][a-z A-Z -./0-9]*")
  tempDirections=($(echo "$response" | grep -Eo "\"narrative\":\"[a-z A-Z -./0-9]*"))
  distances=($(echo "$response" | grep -Eo "distance\":[0-9]*[.][0-9]*" | grep -Eo "[^distance\":][0-9]*[.][0-9]*"))
  totalDist=${distances[0]}
  count="0"
  count="-1"
  temp=${tempDirections[0]}
  for direct in "${tempDirections[@]}"; do
    if [[ $(echo "$direct" | grep -Eo "narrative") == "narrative" ]]; then
      count=$(echo $count + 1 | bc)
      directions[$count]=$temp
      temp=$(echo "$direct" | grep -Eo "[^\"narrative:\"][a-z A-Z 0-9./]*" | sed s/'","iconUrl"'//g)
    else
      temp="$temp $direct"
    fi
  done
  #for distance in $tempDistances
  directions[0]=$firstDirection
}

getDirectionsMap()
{
  echo "Generating route map from $unformattedFromLocation to $unformattedToLocation"
  mkdir ~/temp || return 1
  httpGet "https://www.mapquestapi.com/staticmap/v5/map?start=$1&end=$2&size=600,400@2x&key=$MAPQUEST_API_KEY" >> ~/temp/routeImage.png || return 1
  if [[ $(uname -s) == "Linux" ]]; then
    display ~/temp/routeImage.png > /dev/null || return 1
  elif [[ $(uname -s) == "Darwin" ]]; then
    open ~/temp/routeImage.png > /dev/null
  fi
  rm -rf ~/temp > /dev/null
}

printDirections()
{
  echo
  echo "From $unformattedFromLocation to $unformattedToLocation ($totalDist mi)"
  echo "==================================================="
  count=0
  for direct in "${directions[@]}"; do
    if [ $count -ne 0 ]; then echo -n "$(echo $count | bc)). "; fi
    if [[ $direct != "" ]]; then # sometimes original Narrative is blank
      direct="$direct (${distances[$(echo $count + 1 | bc)]} mi)"
      if [ $count -ne 0 ]; then echo "$direct"; fi
      count=$(echo $count + 1 | bc)
    fi
  done
  echo "Welcome to $unformattedToLocation"
  echo "==================================================="
  echo
}

getLocations()
{
  echo -n "Enter your starting location: "
  read fromLocation
  echo -n "Enter your destination: "
  read toLocation
  unformattedFromLocation=$fromLocation
  unformattedToLocation=$toLocation
  fromLocation=$(echo "$fromLocation" | sed s/','/"+"/g | sed  s/' '/"+"/g )
  toLocation=$(echo "$toLocation" | sed s/','/"+"/g | sed  s/' '/"+"/g )
}

checkImagemagick()
{
  if [[ $(uname -s) == "Linux" ]]; then
    if ! command -v display &>/dev/null; then
      echo "Error: you need to install imagemagick to use map features." &>2
      return 1
    else
      return 0
    fi
  else
    return 0
  fi
}

getMapLocation()
{
  echo -n "Enter the city or address you want to generate a map for: "
  read mapLocation
  echo "Generating static map for $mapLocation"
  mapLocation=$(echo "$mapLocation" | sed  s/','/"+"/g | sed  s/' '/"+"/g )
}

getStaticMap()
{
  mkdir ~/temp || return 1
  httpGet "https://www.mapquestapi.com/staticmap/v5/map?key=$MAPQUEST_API_KEY&center=$1&zoom=15&type=hyb&size=600,400@2x" >> ~/temp/mapImage.png || return 1
  if [[ $(uname -s) == "Linux" ]]; then
    display ~/temp/mapImage.png > /dev/null || return 1
  elif [[ $(uname -s) == "Darwin" ]]; then
    open ~/temp/mapImage.png > /dev/null || return 1
  fi
  rm -rf ~/temp > /dev/null || return 1
}

usage()
{
  cat <<EOF
Maps
Description: Get directions between locations, generate static maps of locations, and generate route maps for directions.
Usage: maps [flags]
    -u  Update Bash-Snippet Tools
    -d  Get directions from a location to a destination
    -r  Generate route map (must be used with the -d flag)
    -m  Generate static map
          * By itself will ask for a location to generate a map
          * In conjunction with the -d flag will generate maps for the start location and the destination
    -h  Show the help
    -v  Get the tool version
Examples:
    maps -d
    maps -d -r -m
    maps -m
    maps -d -m
EOF
}

getConfiguredClient || exit 1

## getDirections Denver Boulder || exit 1
## printDirections Denver Boulder || exit 1
## getDirectionsMap Denver Boulder || exit 1
## getStaticMap Paramus || exit 1

while getopts "drmuvh" opt; do
  case "$opt" in
    \?) echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    h)  usage
        exit 0
        ;;
    d)  directionsFlag="1" ;;
    m)  staticMapFlag="1" ;;
    r)  directionsMapFlag="1" ;;
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

if [[ $directionsMapFlag == "1" && $directionsFlag == "0" ]]; then { echo "Error the -r flag only works in conjunction with the -d flag."; exit 1; }; fi

if [[ $# == 0 ]]; then
  usage
  exit 0
elif [[ $# == "1" ]]; then
  if [[ $1 == "update" ]]; then
    checkInternet || exit 1
    update
    exit 0
  elif [[ $1 == "help" ]]; then
    usage
    exit 0
  fi
fi
checkInternet || exit 1
if [[ $directionsFlag == "0" && $staticMapFlag == "1" ]]; then
  checkImagemagick || exit 1
  getMapLocation || exit 1
  getStaticMap "$mapLocation" || exit 1
elif [[ $directionsFlag == "1" ]]; then
  getLocations || exit 1
  getDirections "$fromLocation" "$toLocation" || exit 1
  printDirections "$fromLocation" "$toLocation" || exit 1
  checkImagemagick || exit 1
  if [[ $directionsMapFlag == "1" ]]; then getDirectionsMap "$fromLocation" "$toLocation" || exit 1; fi
  if [[ $staticMapFlag = "1" ]]; then
    echo "Generating static map for $unformattedFromLocation" && getStaticMap "$fromLocation" || exit 1
    echo "Generating static map for $unformattedToLocation" && getStaticMap "$toLocation"  || exit 1
  fi
fi
