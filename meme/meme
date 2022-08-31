#!/usr/bin/env bash
# Author: Navan Chauhan https://github.com/navanchauhan
currentVersion="1.23.0"
configuredClient=""
fileName=""
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
    curl)  curl -A curl -Ls "$@" ;;
    wget)  wget -qO- "$@" ;;
    httpie) http -b GET "$@" ;;
    fetch) fetch -q "$@" ;;
  esac
}

update()
{
  # Author: Alexander Epstein https://github.com/alexanderepstein
  # Update utility version 1.2.0
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

main(){
    echo -n "Enter the name for the meme's background (Ex. buzz, doge, blb ): "
    read bg
    echo -n "Enter the text for the first line: "
    read raw_first
    almost_first=$(echo "$raw_first" | awk '{print tolower($0)}')
    first=$(echo "$almost_first" | sed -e 's/ /_/g')
    echo -n "Enter the text for the second line: "
    read raw_second
    almost_second=$(echo "$raw_second" | awk '{print tolower($0)}')
    second=$(echo "$almost_second" | sed -e 's/ /_/g')
    if [ -z "$first" ]
    then
    first=$(echo "_")
    else
      echo ""
    fi
    if [ -z "$second" ]
    then
    second=$(echo "_")
    else
      echo ""
    fi
    httpGet "https://memegen.link/$bg/$first/$second.jpg"  >> "$fileName".png || return 1
    return 0
}

usage()
{
  cat <<EOF
Meme
Description: A lightning fast meme generator
Usage: tool [flags] or tool [flags] [arguments]
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -f  Choose the output filename
  -v  Get the tool version
Examples:
   meme -h
   meme -f dogeMeme
EOF
}



while getopts "uvhf:" opt; do
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
    f)
        fileName=$OPTARG
        getConfiguredClient || exit 1
        checkInternet || exit 1
        main || exit 1
        exit 0
    ;;
    :)  echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done




# special set of first arguments that have a specific behavior across tools
if [[ $# == "0" ]]; then
  getConfiguredClient || exit 1
  checkInternet || exit 1
  if [[ $fileName == "" ]]; then
    fileName="meme"
  fi
  main || exit 1
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
