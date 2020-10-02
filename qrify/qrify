#!/usr/bin/env bash
# Author: Linyos Torovoltos github.com/linyostorovovoltos

currentVersion="1.23.0"
multiline="0" # flag that indicates multiline option
fileoutput="0" # flag indicating the -f option


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

makeqr()
{
  input=$(echo "$input" | sed s/" "/%20/g ) ## replace all spaces in the sentence with HTML-encoded space %20
  httpGet qrenco.de/"$input" ## get a response for the qrcode
}

# redirects the image obtained from the goqr api into a png file
makeQRFile() {
	input=$(echo "$input" | sed -e s/" "/%20/g -e s/'\\n'/%0A/g ) ##same as in the makeqr function

  addFileExt

	httpGet "api.qrserver.com/v1/create-qr-code/?size=150x150&data=$input" > "$fileName"
}

addFileExt() {
  if ! echo "$fileName" | grep -E -q ".*\.png$|.*\.PNG$"
  then
    fileName="$fileName.png"
  fi
}

makeMultiLineQr()
{
  if [[ ${configuredClient} != "curl" ]]; then ## prevent usage without curl it is unreliable
    echo "Multiline currently only supports curl!"
    return 1
  else
    input=$(echo "$input" | sed -e s/" "/%20/g -e s/'\\n'/%0A/g ) ##same as in the makeqr function
    printf "%s" "$input"  | curl -F-=\<- qrenco.de
  fi
}

# Function to get the json response from POST request
decodeQR() {
  local qrFile="$1"
  if ! echo "$fileName" | grep -E -q ".*\.png$|.*\.PNG$|.*\.gif$|.*\.jpg$|.*\.jpeg$|.*\.GIF$|.*\.JPG$|.*\.JPEG$"
  then
    exit 1
  fi

  # only uses curl
  # Cannot use wget because it does not support multipart/form-data (as per the man page)]

  case "$configuredClient" in
    curl) JSONresponse=$(curl -s -F "file=@$qrFile" http://api.qrserver.com/v1/read-qr-code/) || exit 1;;
    wget) echo "Error:-Not supported with wget" >&2 && exit 1;;
    httpie) JSONresponse=$(http -b --form POST http://api.qrserver.com/v1/read-qr-code/ file@"$qrFile") || exit 1;;
    fetch) echo "Error:-Not supported with wget" >&2 && exit 1;;
  esac

  error="$(echo "$JSONresponse" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)[0]['symbol'][0]['error'])")"
  
  if [[ "$error" == "None" ]]
  then
    data="$(echo "$JSONresponse" | python -c "from __future__ import print_function; import sys, json; print(json.load(sys.stdin)[0]['symbol'][0]['data'])")"
  else
    echo "Error:-$error" >&2 && exit 1
  fi
}

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

usage()
{
  cat <<EOF
Qrify
Description: Converts strings or URLs into a QR code.
Usage: qrify [stringtoturnintoqrcode]
    -u  Update Bash-Snippet Tools
    -m  Enable multiline support (feature not working yet)
    -h  Show the help
    -v  Get the tool version
    -f  Store the QR code as a PNG file
    -d  Decode the QR code from a PNG/GIF/JP(E)G file
Examples:
    qrify this is a test string
    qrify -m two\\\\nlines
    qrify github.com (no http:// or https://)
    qrify -f fileoutputName google.com
    qrify -d fileName.png

[31mPlease pay attention:[0m
This script needs access to an external API.
[5m[1mDo not use it to encode sensitive data.[0m
EOF
}

getConfiguredClient || exit 1


while getopts "d:f:m:hvu*:" option
do
  case "${option}" in
    v) echo "Version $currentVersion" && exit 0 ;;
    u) checkInternet && update && exit 0 || exit 1 ;;
    h) usage && exit 0 ;;
    m) multiline="1" && echo "Error this is not a supported feature yet" && exit 1 ;;
		f)
			fileName=$OPTARG
			#file name is the first argument of the option -f
			fileoutput="1";;
    d)
      fileName=$OPTARG
      decode="1";;
  esac
done

if [[ $# == "0" ]]; then
  usage
  exit 0
elif [[ $# == "1" ]];then
  if [[ $1 == "help" || $1 == ":help" ]]; then
    usage
    exit 0
  elif [[ $1 == "update" ]]; then
    checkInternet || exit 1
    update || exit 1
    exit 0
  else
    getConfiguredPython || exit 1
	checkInternet || exit 1
    input=$(printf '%s ' "$@")
    makeqr || exit 1
    exit 0
  fi
else
  getConfiguredPython || exit 1
  checkInternet || exit 1
  if [[ $fileoutput == "1" ]]
	then
		input=$(printf '%s ' "${@:3}") # first arg is -f, second is the file name, third onwards is the rest of the argument
		# will have to be changed when implementing multiline QR code
		makeQRFile || exit 1
		exit 0
  elif [[ $decode == "1" ]]
  then
    ( decodeQR "$fileName" && echo "$data" ) || exit 1
    exit 0
  elif [[ $multiline == "0" ]]; then
    input=$(printf '%s ' "$@")
    makeqr || exit 1
    exit 0
  else
    input=$(printf '%s ' "${@:2}")
    makeMultiLineQr || exit 1 ## if multiline that means a flag existed so start from the second argument
    exit 0
  fi
fi
