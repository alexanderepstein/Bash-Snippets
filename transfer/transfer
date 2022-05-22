#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein
configuredDownloadClient=""
configuredUploadClient=""
configuredClient=""
currentVersion="1.23.0"
down="false"

## This function determines which http get tool the system has installed and returns an error if there isnt one
getConfiguredDownloadClient()
{
  if  command -v curl &>/dev/null; then
    configuredDownloadClient="curl"
  elif command -v wget &>/dev/null; then
    configuredDownloadClient="wget"
  elif command -v fetch &>/dev/null; then
    configuredDownloadClient="fetch"
  else
    echo "Error: Downloading with this tool requires either curl, wget, or fetch to be installed." >&2
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

## This function determines which http get tool the system has installed and returns an error if there isnt one
getconfiguredUploadClient()
{
  if  command -v curl &>/dev/null; then
    configuredUploadClient="curl"
  elif command -v wget &>/dev/null; then
    configuredUploadClient="wget"
  else
    echo "Error: Uploading with this tool requires either curl or wget to be installed." >&2
    return 1
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

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

singleUpload()
{
  filePath=$(echo "$1" | sed s:"~":"$HOME":g)
  if [ ! -f "$filePath" ];then { echo "Error: invalid file path"; return 1;}; fi
  tempFileName=$(echo "$1" | sed "s/.*\///")
  echo "Uploading $tempFileName"
  httpSingleUpload "$filePath" "$tempFileName"
}


httpSingleUpload()
{
  case "$configuredUploadClient" in
    curl) response=$( curl --progress-bar --upload-file $1 "https://free.keep.sh" | tee /dev/null) || { echo "Failure!"; return 1;};;
    wget) response=$(wget --progress=dot --method PUT --body-file="$1" "https://free.keep.sh" | tee /dev/null) || { echo "Failure!"; return 1;} ;;
  esac
  echo  "Success!"
}

printUploadResponse()
{
fileID=$(echo "$response" | cut -d "/" -f 4)
  echo "Transfer Download Command: transfer -d desiredOutputDirectory $fileID $tempFileName"
  echo "Transfer File URL: $response"
  echo -e "\n\n\t Or scan this QR Code"
  qrify $response
}


onetimeUpload()
{
	getConfiguredClient
    checkInternet || exit 0
    getconfiguredUploadClient
  	response=$(curl --progress-bar -T $1 temp.sh)
  	downlink=$(echo "$response")
}


printOnetimeUpload()
{
  	echo -e "\n Download link: $downlink"
  	echo -e "\n\n\t Or scan this QR Code"
  	qrify $downlink
}

singleDownload()
{
  if [[ ! -d $1 ]];then 
  	{
  		echo "Directory doesn't exist, creating it now...";
  		mkdir -p "$1";
  	};
  fi

  tempOutputPath=$1
  if [ -f "$tempOutputPath/$3" ];then
  	echo -n "File aleady exists at $tempOutputPath/$3, do you want to delete it? [Y/n] ";
  	read -r answer
    if [[ "$answer" == [Yy] ]] ;then
    	rm -rf "$tempOutputPath"/"$3";
    	else
    		echo "Stopping download"
    		return 1;
    fi
  fi
  echo "Downloading $3"
  curl -# -L https://free.keep.sh/$2/$3 > $1/$3 || { echo "Failure"; return 1;}
  # curl -# -L https://temp.sh/$2/$3 > $1/$3 || { echo "Failure"; return 1;}
  echo "Success!"
}

usage()
{
  cat <<EOF
Transfer
Description: Quickly transfer files from the command line.
Usage: transfer [flags] or transfer [flag] [args] or transfer [filePathToUpload]
  -d  Download a single file
      First arg: Output file directory
      Second arg: File url id
      Third arg: File name
  -o  Onetime file upload
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Examples:
  transfer ~/fileToTransfer.txt
  transfer ~/firstFileToTransfer.txt ~/secondFileToTransfer.txt ~/thirdFileToTransfer.txt
  transfer -d ~/outputDirectory fileID fileName
  transfer -o ~/fileToTransfer.txt
EOF
}

while getopts "o:d:uvh" opt; do
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
    u)
      getConfiguredClient || exit 1
      checkInternet || exit 1
      update || exit 1
      exit 0
    ;;
    o)
      onetime="true"
    ;;
    d)
      down="true"
      if [ $# -lt 4 ];
      	then
      		echo "Error: not enough arguments for downloading a file, see the usage"; exit 1
      fi
      
      if [ $# -gt 4 ];
      	then
      		echo "Error: to many enough arguments for downloading a file, see the usage"; exit 1
      	fi
      inputFilePath=$(echo "$*" | sed s/-d//g | sed s/-o//g | cut -d " " -f 2)
      inputID=$(echo "$*" | sed s/-d//g | sed s/-o//g | cut -d " " -f 3)
      inputFileName=$(echo "$*" | sed s/-d//g | sed s/-o//g | cut -d " " -f 4)
    ;;
    :)  echo "Option -$OPTARG requires an argument." >&2
      exit 1
    ;;
  esac
done

if [[ $# == "0" ]]; then
  usage
  exit 0
elif [[ $# == "1" ]];then
  if [[ $1 == "help" ]]; then
    usage
    exit 0
  elif [[ $1 == "update" ]]; then
    getConfiguredClient || exit 1
    checkInternet || exit 1
    update || exit 1
    exit 0
  elif [ -f "$1" ];then
    getConfiguredClient || exit 1
    checkInternet || exit 1
    getconfiguredUploadClient || exit 1
    singleUpload "$1" || exit 1
    printUploadResponse
    exit 0
  else
    echo "Error: invalid filepath"
    exit 1
  fi
else
  if $down ;then
    getConfiguredClient || exit 1
    checkInternet || exit 1
    getConfiguredDownloadClient || exit 1
    singleDownload "$inputFilePath" "$inputID" "$inputFileName" || exit 1
    exit 0
  elif ! $down && ! $onetime; then
    getConfiguredClient || exit 1
    checkInternet || exit 1
    getconfiguredUploadClient || exit 1
    for path in "$@";do
      singleUpload "$path" || exit 1
      printUploadResponse
      echo
    done
    exit 0
  elif ! $down && $onetime; then
    getConfiguredClient || exit 1
    if [[ $configuredClient -ne "curl" ]];then
      echo "Error: curl must be installed to use one time file upload"
      exit 1
    fi
    inputFileName=$(echo "$*" | sed s/-o//g | cut -d " " -f 2 )
    onetimeUpload "$inputFileName"
    printOnetimeUpload
  fi
fi
