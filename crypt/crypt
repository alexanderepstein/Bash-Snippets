#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein

currentVersion="1.23.0"
state=""
configuredClient=""

checkOpenSSL()
{
  if  ! command -v openssl &>/dev/null; then
    echo "Error: to use this tool openssl must be installed" >&2
    return 1
  else
    return 0
  fi
}

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

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

## uses openssl aes 256 cbc encryption to encrypt file salting it with password designated by user
encrypt()
{
  echo "Encrypting $1..."
  openssl enc -aes-256-cbc -salt -a -in "$1" -out "$2" || { echo "File not found"; return 1; }
  echo "Successfully encrypted"
}

## uses openssl aes 256 cbc decryption to decrypt file
decrypt()
{
  echo "Decrypting $1..."
  openssl enc -aes-256-cbc -d -a -in "$1" -out "$2" || { echo "File not found"; return 1; }
  echo "Successfully decrypted"
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
Crypt
Description: A wrapper around openssl that facilitates encrypting and decrypting files.
Usage: crypt [flag] [inputFile] [outputFile]
  -e  Encrypt the inputFile and store it in the outputFile
  -d  Decrypt the inputFile and store it in the outputFile
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Examples:
  crypt -e mySecretFile.txt myEncryptedFile.jpg (change filetype so default program is incorrect)
  crypt -d myEncryptedFile.jpg thisIsNowDecrypted.txt (change filetype back so now default program is correct)
EOF
}

checkOpenSSL || exit 1

while getopts "huve:d:" opt; do ## alows for using options in bash
  case $opt in
    e)  ## when trying to encrypt run this
        if [[ $state != "decrypt" ]]; then
          state="encrypt"
        else
          echo "Error: the -d and -e options are mutally exclusive" >&2
          exit 1
        fi
        if [[ $# -ne 3 ]]; then
          echo "Option -e needs and only accepts two arguments [file to encrypt] [output file]" >&2
          exit 1
        fi
        ;;
    \?) echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    d)  ## when trying to decrypt run this
        if [[ $state != "encrypt" ]]; then
          state="decrypt"
        else
          echo "Error: the -e and -d options are mutally exclusive" >&2
          exit 1
        fi
        if [[ $# -ne 3 ]]; then
          echo "Option -d needs and only accepts two arguments [file to decrypt] [output file]" >&2
          exit 1
        fi
        ;;
    u)  getConfiguredClient || exit 1
        checkInternet || exit 1
        update
        exit 0
        ;;
    h)  usage
        exit 0
        ;;
    v)  echo "Version $currentVersion"
        exit 0
        ;;
    :)  ## will run when no arguments are provided to to e or d options
        echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done

if [[ $# == 0 ]]; then
  usage
  exit 0
elif [[ $1 == "update" ]]; then
  getConfiguredClient || exit 1
  checkInternet || exit 1
  update || exit 1
  exit 0
elif [[ $1 == "help" ]]; then
  usage
  exit 0
elif [[ $state == "encrypt" ]]; then
  encrypt "$2" "$3" || exit 1
  exit 0
elif [[ $state == "decrypt" ]]; then
  decrypt "$2" "$3" || exit 1
  exit 0
fi
