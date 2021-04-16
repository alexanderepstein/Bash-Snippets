#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein
# Expanded: Rohit Goswami https://github.com/HaoZeke

unset base
unset exchangeTo
currentVersion="1.23.0"
unset configuredClient
currencyCodes=(AUD BAM BGN BMD BND BRL CAD CHF CNY CZK DJF DKK
  EUR GBP HKD HRK HUF IDR ISK ILS INR
  JPY KRW MXN MYR NOK NZD PAB PHP PLN
  RON RUB SEK SGD THB TRY USD ZAR)

  ## This function determines which http get tool the system has installed and returns an error if there isnt one
  getConfiguredClient()
  {
    if command -v curl &>/dev/null; then
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

  peggedTo()
  {
    case "$@" in
      BAM)  echo "EUR:1.95583" ;;
      BMD)  echo "USD:1.0" ;;
      BND)  echo "SGD:1.0" ;;
      DJF)  echo "USD:177.721" ;;
      PAB)  echo "USD:1.0" ;;
      *)    echo "1" ;;
    esac
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

checkValidCurrency()
{
  if [[ "${currencyCodes[*]}" == *"$(echo "${@}" | tr -d '[:space:]')"* ]]; then
    echo "0"
  else
    echo "1"
  fi
}

## Grabs the base currency from the user and validates it with all the possible currency
## types available on the API and guides user through input (doesnt take in arguments)
getBase()
{
  echo -n "What is the base currency: "
  read -r base
  base=$(echo "$base" | tr /a-z/ /A-Z/)
  if [[ $(checkValidCurrency "$base") == "1" ]]; then
    unset base
    echo "Invalid base currency"
    getBase
  fi
}

## Checks base currency from the user and validates it with all the possible currency
## types available on the API (requires argument)
checkBase()
{
  base=$1
  base=$(echo "$base" | tr /a-z/ /A-Z/)
  if [[ $(checkValidCurrency "$base") == "1" ]]; then
    unset base
    echo "Invalid base currency"
    exit 1
  fi
}

## Grabs the exchange to currency from the user and validates it with all the possible currency
## types available on the API and guides user through input (doesnt take in arguments)
getExchangeTo()
{
  echo -n "What currency to exchange to: "
  read -r exchangeTo
  exchangeTo=$(echo "$exchangeTo" | tr /a-z/ /A-Z/)
  if [[ $(checkValidCurrency "$exchangeTo") == "1" ]]; then
    echo "Invalid exchange currency"
    unset exchangeTo
    getExchangeTo
  fi
}

## Grabs the exchange to currency from the user and validates it with all the possible currency
## types available on the API (requires arguments)
checkExchangeTo()
{
  exchangeTo=$1
  exchangeTo=$(echo "$exchangeTo" | tr /a-z/ /A-Z/)
  if [[ $(checkValidCurrency "$exchangeTo") == "1" ]]; then
    echo "Invalid exchange currency"
    unset exchangeTo
    exit 1
  fi
}

## Get the amount that will be exchanged and validate that the user has entered a number (decimals are allowed)
## doesnt take in argument, it guides user through input
getAmount()
{
  echo -n "What is the amount being exchanged: "
  read -r amount
  if [[ ! "$amount" =~ ^[0-9]+(\.[0-9]+)?$ ]]
  then
    echo "The amount has to be a number"
    unset amount
    getAmount
  fi
}

## Get the amount that will be exchanged
## validate that the user has entered a number (decimals are allowed and requires argument)
checkAmount()
{
  amount=$1
  if [[ ! "$amount" =~ ^[0-9]+(\.[0-9]+)?$ ]]
  then
    echo "The amount has to be a number"
    unset amount
    exit 1
  fi
}

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

## Grabs the exchange rate and does the math for converting the currency
convertCurrency()
{
  trueBase=$base
  trueTarget=$exchangeTo
  peggedBase=$( peggedTo "$base" )
  peggedTarget=$( peggedTo "$exchangeTo" )
  coef1="1"
  coef2="1"
  if [[ "$peggedBase" =~ ^[A-Z]+:[0-9.]+$ ]]; then
    trueBase=$(echo "$peggedBase" | grep -Eo "^[A-Z]*")
    coef1=$(echo "$peggedBase" | grep -Eo "[0-9.]*$")
  fi
  if [[ "$peggedTarget" =~ ^[A-Z]+:[0-9.]+$ ]]; then
    trueTarget=$(echo "$peggedTarget" | grep -Eo "^[A-Z]*")
    coef2=$(echo "$peggedTarget" | grep -Eo "[0-9.]*$")
  fi
  if [[ "$trueBase" == "$exchangeTo" || "$base" == "$trueTarget" ]]; then
    exchangeRate="1"
  else
    exchangeRate=$(httpGet "https://api.exchangerate-api.com/v4/latest/$trueBase" | grep -Eo "$trueTarget\":[0-9.]*" | grep -Eo "[0-9.]*") > /dev/null
  fi
  if ! command -v bc &>/dev/null; then
    exchangeRate=$(echo "$exchangeRate" | grep -Eo "^[0-9]*" )
    amount=$(echo "$amount" | grep -Eo "^[0-9]*" )
    coef1=$(echo "$coef1" | grep -Eo "^[0-9]*" )
    exchangeRate=$(( exchangeRate / coef1 ))
    exchangeRate=$(( exchangeRate * coef2 ))
    exchangeAmount=$(( exchangeRate * amount ))
  else
    exchangeRate=$( echo "scale=8; $exchangeRate / $coef1" | bc )
    exchangeRate=$( echo "$exchangeRate * $coef2" | bc )
    exchangeAmount=$( echo "$exchangeRate * $amount" | bc )
  fi

  cat <<EOF
=========================
| $base to $exchangeTo
| Rate: $exchangeRate
| $base: $amount
| $exchangeTo: $exchangeAmount
=========================
EOF
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
Currency
Description: A realtime currency converter.
   With no flags it will guide you through the currency exchange
Usage: currency or currency [flag] or currency [base] [exchangeTo] [amount]
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Supported Currencies:
 ______________________________
| AUD | BGN | BRL | CAD | ZAR |
| CHF | CNY | CZK | DKK |     |
| EUR | GBP | HKD | HRK |     |
| HUF | ISK | IDR | ILS |     |
| INR | JPY | KRW | MXN |     |
| MYR | NOK | NZD | PHP |     |
| PLN | RON | RUB | SEK |     |
| SGD | THB | TRY | USD |     |
 ______________________________
Examples:
  currency EUR USD 12.35
  currency
EOF
}

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
    u)  checkInternet || exit 1 # check if we have a valid internet connection if this isnt true the rest of the script will not work so stop here
        update
        exit 0
        ;;
    :)  echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done

if [[ $# == 0 ]]; then
  checkInternet || exit 1 # check if we have a valid internet connection if this isnt true the rest of the script will not work so stop here
  getBase # get base currency
  getExchangeTo # get exchange to currency
  getAmount # get the amount to be converted
  convertCurrency # grab the exhange rate and perform the conversion
  exit 0
elif [[ $# == "1" ]]; then
  if [[ $1 == "update" ]]; then
    update
  elif [[ $1 == "help" ]]; then
    usage
  else
    echo "Not a valid argument"
    usage
    exit 1
  fi
elif [[ $# == "2" ]]; then
  echo "Not a valid argument"
  usage
  exit 1
elif [[ $# == "3" ]]; then
  checkInternet || exit 1 # check if we have a valid internet connection if this isnt true the rest of the script will not work so stop here
  checkBase "$1"
  checkExchangeTo "$2"
  checkAmount "$3"
  convertCurrency
  exit 0
else
  echo "Error: too many arguments."
fi
