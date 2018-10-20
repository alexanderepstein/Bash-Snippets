#!/usr/bin/env bash

# Bash utility for getting specific network info
# Author: Jake Meyer
# Github: https://github.com/jakewmeyer

currentVersion="1.22.1"
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

# Parse arguments passed + help formatting
usage() {
  cat <<EOF
Geo
Description: Provides quick access for wan, lan, router, dns, mac, and ip geolocation data
Usage: geo [flag]
  -w  Returns WAN IP
  -l  Returns LAN IP(s)
  -r  Returns Router IP
  -d  Returns DNS Nameserver
  -m  Returns MAC address for interface. Ex. eth0
  -g  Returns Current IP Geodata
Examples:
  geo -g
  geo -wlrdgm eth0
Custom Geo Output => [all] [query] [city] [region] [country] [zip] [isp]
Example: geo -a 8.8.8.8 -o city,zip,isp
  -o [options]  Returns Specific Geodata
  -a [address]  For specific IP in -s
  -v            Returns Version
  -h            Returns Help Screen
  -u            Updates Bash-Snippets
EOF
    exit
}

# Displays version number
version() {
  echo "Version $currentVersion"
}

# Fetches WAN IP address
wan_search() {
  httpGet https://api.ipify.org?format=json | grep -Eo "[0-9.]*"
}

# Fetches current LAN IP address
lan_search() {
  if [ "$(uname)" = "Darwin" ]; then
    ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
  elif [ "$(uname -s)" = "Linux" ]; then
    ip addr show | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
  else
    echo "OS not supported"
    exit 1
  fi
}

# Fetches Router ip address
router_search() {
  if [ "$(uname)" = "Darwin" ]; then
    netstat -rn | grep default | head -1 | awk '{print$2}'
  elif [ "$(uname -s)" = "Linux" ]; then
    ip route | grep ^default'\s'via | head -1 | awk '{print$3}'
  else
    echo "OS not supported"
    exit 1
  fi
}

# Fetches DNS nameserver
dns_search() {
  if [ "$(uname)" = "Darwin" ]; then
    grep -i nameserver /etc/resolv.conf |head -n1|cut -d ' ' -f2
  elif [ "$(uname -s)" = "Linux" ]; then
    cat /etc/resolv.conf | grep -i ^nameserver | cut -d ' ' -f2
  else
    echo "OS not supported"
    exit 1
  fi
}

# Fetches MAC address of
mac_search() {
  if [ "$(uname)" = "Darwin" ]; then
    ifconfig "$MAC" | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'
  elif [ "$(uname -s)" = "Linux" ]; then
    ip addr show "$MAC" | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | grep -v ff:
  else
    echo "OS not supported"
    exit 1
  fi
}

# Fetches current geodata based on ip
geodata_search() {
  httpGet "http://ip-api.com/line/?fields=query,city,region,country,zip,isp"
}

# Fetches specific geodata based on args
specific_geo() {
  if [ "$OPTIONS" = "all" ]; then
    httpGet "http://ip-api.com/line/${ADDRESS}?fields=query,city,region,country,zip,isp"
  else
    httpGet "http://ip-api.com/line/${ADDRESS}?fields=${OPTIONS}"
  fi
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

checkInternet() {
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

# Option parsing "controller"
optspec="uwlrdm:go:a:vh*:"
while getopts "$optspec" optchar; do
  case "${optchar}" in
    w) getConfiguredClient && checkInternet && wan_search || exit 1 ;;
    l) lan_search ;;
    r) router_search ;;
    d) dns_search ;;
    m) MAC=$OPTARG mac_search ;;
    g) getConfiguredClient && checkInternet && geodata_search || exit 1 ;;
    a) ADDRESS=$OPTARG ;;
    o) getConfiguredClient && checkInternet && OPTIONS=$OPTARG specific_geo || exit 1 ;;
    v) version ;;
    h) usage ;;
    u) getConfiguredClient && checkInternet && update || exit 1 ;;
    *) usage ;;
  esac
done

# Makes geo command default to help screen for usability
if [ $# -eq 0 ]; then
  usage
  exit 0
elif [[ $1 == "update" ]]; then
  getConfiguredClient && checkInternet && update || exit 1
elif [[ $1 == "help" ]]; then
  usage
  exit 0
fi
