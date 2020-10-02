#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein
# Author: Navan Chauhan https://github.com/navanchauhan
# Author: Tyler Stubenvoll https://github.com/tjstub

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
      python3) python3 "$@" ;;
      python2) python2 "$@" ;;
      python)  python "$@" ;;
    esac
  }
fi

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

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

## This function grabs information about a stock and prints it for consumption
printStockInformation()
{
  # this data is updated hourly.
  stockProfile="$(httpGet "https://financialmodelingprep.com/api/v3/company/profile/${1}")" > /dev/null
  # this is realtime data.
  stockPrice="$(httpGet "https://financialmodelingprep.com/api/v3/stock/real-time-price/${1}")" > /dev/null
  # necessary for python in some cases
  export PYTHONIOENCODING=utf8
  # checking if we get any information back from the server if not 
  # chances are it isnt a valid stock symbol
  AccessJsonElement "$stockProfile" "profile" "companyName" > /dev/null 2>&1 \
    || { echo "$1: Not a valid stock symbol"; exit 1; } 
  # The rest of the code is just extrapolating the data with python 
  # from the JSON response
  name="$(AccessJsonElement "$stockProfile" "profile" "companyName")"
  exchangeName="$(AccessJsonElement "$stockProfile" "profile" "exchange")"
  latestPrice="$(AccessJsonElement "$stockPrice" "price")"
  range="$(AccessJsonElement "$stockProfile" "profile" "range")"
  priceChange="$(AccessJsonElement "$stockProfile" "profile" "changes")"
  priceChangePercentage="$(AccessJsonElement "$stockProfile" "profile" "changesPercentage")"
  volumeAvg="$(AccessJsonElement "$stockProfile" "profile" "volAvg")"

  cat <<EOF

==============================================
| $name -- Stock Information
==============================================
| Stock Details
|   * symbol: $1
|   * Exchange: $exchangeName
| Real time data
|   * Latest Price: $latestPrice
| Hourly data
|   * 52 week range: $range
|   * Price Change: $priceChange
|   * PriceChangePercent: $priceChangePercentage
|   * Volume average: $volumeAvg
==============================================
EOF

}

## This function queries yahoo to determine the stock ticker for a certain company
## this allows the usage of stocks to be extended where now you can enter stocks appple
## and it will determine the stock symbol for apple is AAPL and move on from there
getTicker()
{
  input="$(echo "$@" | tr " " +)"
  response="$(httpGet "http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=$input&region=1&lang=en%22")" > /dev/null
  # using python to extrapolate the stock symbol
  symbol="$(echo "$response" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)['ResultSet']['Result'][0]['symbol'])")"
  # just unsets the entire response after using it since all I need is the stock ticker
  unset response 
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
Stocks
Description: Finds the latest information on a certain stock.
Usage: stocks [flag] or stocks [company/ticker]
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Examples:
  stocks AAPL
  stocks Tesla
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
  # the company name might have spaces so passing in all args allows for this
  getTicker "$@"
  # based on the stock symbol exrapolated by the getTicker function get 
  # information on the stock
  printStockInformation "$symbol"
  exit 0
fi

