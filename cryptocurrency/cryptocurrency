#!/usr/bin/env bash
# Original Author: Jonas-Taha El Sesiy https://github.com/elsesiy
# Modifications: Alexander Epstein

unset base
unset exchangeTo
old="false"
currentVersion="1.23.0"
unset configuredClient

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

## Top 10 cryptocurrencies as base
checkValidCurrency()
{
  if [[ $1 != "BTC" && $1 != "ETH" \
      && $1 != "XRP" && $1 != "LTC" && $1 != "XEM" \
      && $1 != "ETC" && $1 != "DASH" && $1 != "MIOTA" \
      && $1 != "XMR" && $1 != "STRAT" && $1 != "BCH" ]]; then
    echo "1"
  else
    echo "0"
  fi
}

checkTargetCurrency()
{
  if [[ $1 != "AUD" && $1 != "BRL" \
      && $1 != "CAD" && $1 != "CHF" && $1 != "CNY" \
      && $1 != "EUR" && $1 != "GBP" && $1 != "HKD" \
      && $1 != "IDR" && $1 != "INR" && $1 != "JPY" && $1 != "KRW" \
      && $1 != "MXN" && $1 != "RUB" && $1 != "USD" ]]; then
    echo "1"
  else
    echo "0"
  fi
}

## Grabs the base currency from the user and validates it with all the possible currency
## types available on the API and guides user through input (doesnt take in arguments)
getBase()
{
  echo -n "What is the base currency: "
  read -r base
  base=$(echo "$base" | tr /a-z/ /A-Z/)
  if [[ $(checkValidCurrency "$base") == "1"  ]]; then
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

# Matches the symbol to the appropriate ids regarding the API calling.
transformBase()
{
  case "$base" in
    "ETH") reqId="ethereum" ;;
    "BTC") reqId="bitcoin" ;;
    "XRP") reqId="ripple" ;;
    "LTC") reqId="litecoin" ;;
    "XEM") reqId="nem" ;;
    "ETC") reqId="ethereum-classic" ;;
    "DASH") reqId="dash" ;;
    "MIOTA") reqId="iota" ;;
    "XMR") reqId="monero" ;;
    "STRAT") reqId="stratis" ;;
    "BCH") reqId="bitcoin-cash" ;;
  esac
}

## Grabs the exchange to currency from the user and validates it with all the possible currency
## types available on the API and guides user through input (doesnt take in arguments)
getExchangeTo()
{
  echo -n "What currency to exchange to: "
  read -r exchangeTo
  exchangeTo=$(echo "$exchangeTo" | tr /a-z/ /A-Z/)
  if [[ $(checkTargetCurrency "$exchangeTo") == "1" ]]; then
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
  if [[ $(checkTargetCurrency "$exchangeTo") == "1" ]]; then
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
  if [[ ! "$amount" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
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
  if [[ ! "$amount" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
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
  exchangeTo=$(echo "$exchangeTo" | tr '[:upper:]' '[:lower:]')
  exchangeRate=$(httpGet "https://api.coinmarketcap.com/v1/ticker/$reqId/?convert=$exchangeTo" | grep -Eo "\"price_$exchangeTo\": \"[0-9 .]*" | sed s/"\"price_$exchangeTo\": \""//g) > /dev/null
  if ! command -v bc &>/dev/null; then
    oldRate=$exchangeRate
    exchangeRate=$(echo "$exchangeRate" | grep -Eo "^[0-9]*" )
    amount=$(echo "$amount" | grep -Eo "^[0-9]*" )
    exchangeAmount=$(( $exchangeRate * $amount ))
    exchangeRate=$oldRate
  else
    exchangeAmount=$( echo "$exchangeRate * $amount" | bc )
  fi
  exchangeTo=$(echo "$exchangeTo" | tr '[:lower:]' '[:upper:]')

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
CryptoCurrency

Description: A realtime cryptocurrency converter.
With no flags it will pull down the latest stats of the top 10 cryptos

Usage: cryptocurrency or cryptocurrency [flag] or cryptocurrency [flag] [arg]
   -o Utilize the old functionality of the tool
   -f Fiat currency for conversions
   -u Update Bash-Snippet Tools
   -h Show the help
   -v Get the tool version
EOF
}




while getopts "c:of:uvh" opt; do
  case "$opt" in
    \?) echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    c)
        currency=$OPTARG
        ;;
    h)  usage
        exit 0
        ;;
    f)
        fiat=$OPTARG
        ;;
    o)
        old="true"
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

if $old;then
getConfiguredClient || exit 1
getBase # get base currency
getExchangeTo # get exchange to currency
getAmount # get the amount to be converted
transformBase
convertCurrency # grab the exhange rate and perform the conversion
exit 0
fi



if [[ $1 == "update" ]]; then
  getConfiguredClient || exit 1
  checkInternet || exit 1 # check if we have a valid internet connection if this isnt true the rest of the script will not work so stop here
  update
  exit 0
elif [[ $1 == "help" ]]; then
  usage
  exit 0
fi

getConfiguredClient || exit 1
checkInternet || exit 1
link="rate.sx"
if [[ $fiat =~ [a-zA-Z] ]]; then
  link="$fiat.$link"
fi

if [[ $currency =~ [a-zA-Z] ]]; then
  link="$link/$currency"
fi

httpGet "$link"
