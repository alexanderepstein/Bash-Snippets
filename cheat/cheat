#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein

currentVersion="1.23.0"
configuredClient=""
## rest of these variables are search flags
search="0"
insensitive=""
recursive=""
boundry=""

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

usage()
{
cat <<EOF
Cheat
Description: Cheatsheets for quick information about multiple programming languages along with terminal commands
Usage: cheat [flags] [command] or cheat [flags] [programming language] [subject]
  -s  Does a search for last argument rather than looking for exact match
  -i  Case insensitive search
  -b  Word boundaries in search
  -r  Recursive search
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Special Pages:
  hello      Describes building the hello world program written in the language
  list       This lists all cheatsheets related to previous arg if none it lists all cheatsheets
  learn      Shows a learn-x-in-minutes language cheat sheet perfect for getting started with the language
  1line      A collection of one-liners in this language
  weirdness  A collection of examples of weird things in this language
Examples:
  cheat rust hello
  cheat -r -b -i go
  cheat julia Functions
  cheat -i go operators
EOF
}

getCheatSheet()
{
  if [[ $# == 1 ]]; then
    if [[ $search == "1" ]]; then
      link=cheat.sh/~$1
    else
      link=cheat.sh/$1
    fi
  else
    link=cheat.sh/$1
  fi

  if [[ $# == 2 ]]; then
    if [[ $search == "1" ]]; then
      link+=/~$2 ## add this to end of link where ~ indicates search
    else
      link+=/$2 ## add this to end of link
    fi
  fi

  if [[ $insensitive != "" || $recursive != "" || $boundry != "" ]]; then link+=/$boundry$insensitive$recursive; fi ## add this to the end of the link as flags

  httpGet $link
}


### This function just wraps some of the special pages provided by cheat.sh
checkSpecialPage()
{
  temp=$1
  if [[ $1 == "list" ]]; then
    temp=":list"
  elif [[ $1 == "learn" ]]; then
    temp=":list"
  elif [[ $1 == "styles" ]]; then
    temp=":styles"
  fi
  if [[ $2 == "1" ]]; then
    arg1=$temp
  else
    arg2=$temp
  fi
}

getConfiguredClient || exit 1


while getopts "ribuvhis" opt; do
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
        checkInternet || exit 1
        update
        exit 0
        ;;
    i)  insensitive="i"
        search="1"
        ;;
    b)  boundry="b"
        search="1"
        ;;
    r)  recursive="r"
        search="1"
        ;;
    s)  search="1"
        ;;
    :)  echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done

### This functions sets arg 1 and arg 2 to be unqique items after the options
for arg; do
  if [[ $arg != "-r" && $arg != "-s" && $arg != "-b" && $arg != "-i" ]]; then
    if [ -z ${arg1+x} ]; then
      arg1=$arg
    fi
    if [ ! -z ${arg1+x} ]; then
      arg2=$arg
    fi
  fi
done

## check for special pages before moving on
checkSpecialPage "$arg1" 1
checkSpecialPage "$arg2" 2

if [[ $# == 0 ]]; then
  usage
  exit 0
elif [[ $1 == "update" ]]; then
  checkInternet || exit 1
  update
  exit 0
elif [[ $1 == "help" || $1 == ":help" ]]; then ## shows the help and prevents the user from seeing cheat.sh/:help
  usage
  exit 0
else
  checkInternet || exit 1
  if [[ $arg1 != $arg2 ]]; then ## if they equal each other that means there was no arg 2 supplied
    getCheatSheet "$arg1" "$arg2"
    exit 0
  else
    getCheatSheet "$arg1"
    exit 0
  fi
  exit 0
fi
