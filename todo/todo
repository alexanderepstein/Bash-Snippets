#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein
flag=""
currentVersion="1.23.0"
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

addTask()
{
  if [ ! -f ~/.todo/list.txt ]; then
    if [ ! -d ~/.todo ]; then mkdir ~/.todo; fi
    touch ~/.todo/list.txt
  fi
  echo "$1       ;      $(date)" >> ~/.todo/list.txt
}

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

removeTask()
{
  ## Check for valid task numbers (valid characters)
  if [ -f ~/.todo/temp.txt ];then rm -f ~/.todo/temp.txt;fi
  touch ~/.todo/temp.txt
  for taskToRemove in "$@";do
    oldTaskNumber=$taskToRemove
    taskNumber=$( echo "$taskToRemove" | grep -Eo "[0-9]*" )
    if [[ $taskNumber == "" || $oldTaskNumber != $taskNumber ]]; then echo "Error: $oldTaskNumber is not a valid task number!" && return 1; fi
  done
  count="0"
  IFS=$'\n'       # make newlines the only separator

  ## Removing the task (only don't add to temp if we should remove it)
  for task in $(cat ~/.todo/list.txt); do
    removeIt="false"
    for taskToRemove in "$@";do
      if [[ $(($count + 1)) == "$taskToRemove" ]]; then
      removeIt="true"
      break
      fi
    done
    if ! $removeIt ;then echo "$task" >> ~/.todo/temp.txt;fi
    count=$(( $count + 1 ))
  done
  rm -f ~/.todo/list.txt
  cp  ~/.todo/temp.txt ~/.todo/list.txt
  rm -f ~/.todo/temp.txt

  ##Checking if the task exists
  for taskToRemove in "$@" ;do
    if [ $count -lt "$taskToRemove" ]; then
      echo "Error: task number $taskToRemove does not exist!"
    else
      echo "Sucessfully removed task number $taskToRemove"
    fi
  done
}

getTasks()
{
  if [ -f ~/.todo/list.txt ]; then
    checkEmpty=$(cat ~/.todo/list.txt)
    if [[ $checkEmpty == "" ]]; then
      echo "No tasks found"
    else
      count="1"
      IFS=$'\n'       # make newlines the only separator
      for task in $(cat ~/.todo/list.txt); do
        tempTask=$count
        if [ $count -lt 10 ]; then tempTask="0$count"; fi
        echo "$tempTask). $task"  >> ~/.todo/getTemp.txt
        count=$(( $count + 1 ))
      done
      cat ~/.todo/getTemp.txt | column -t -s ";"
      rm -f ~/.todo/getTemp.txt
    fi
  else
    echo "No tasks found"
  fi
}

usage()
{
  cat <<EOF
Todo
Description: A simplistic commandline todo list.
Usage: todo [flags] or todo [flags] [arguments]
  -c  Clear all the current tasks
      Can also use clear instead of -c
  -r  Remove the following task numbers seprated by spaces
      Can also use remove instead of -r
  -g  Get the current tasks
      Can also use list instead of -g
  -a  Add the following task
      Can also use add instead of -a
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Examples:
   todo -a My very first task
   todo remove 2
   todo -r 1 3
   todo add Another Task
   todo list
   todo -g
   todo -c
   todo clear
EOF
}

clearAllTasks()
{
  rm -f ~/.todo/list.txt || return 1
  touch ~/.todo/list.txt || return 1
  echo "Tasks cleared."
}

while getopts "cr:a:guvh" opt; do
  case "$opt" in
    \?) echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    c)  if [[ $flag == "" ]]; then
          flag="clear"
        else
          echo "Error: all flags are mutually exclusive"
          exit 1
        fi
        ;;
    h)  usage
        exit 0
        ;;
    v)  echo "Version $currentVersion"
        exit 0
        ;;
    g)  if [[ $flag == "" ]]; then
          flag="get"
        else
          echo "Error: all flags are mutually exclusive"
          exit 1
        fi
        ;;
    r)  if [[ $flag == "" ]]; then
          flag="remove"
        else
          echo "Error: all flags are mutually exclusive"
          exit 1
        fi
        ;;
    a)  if [[ $flag == "" ]]; then
          flag="add"
        else
          echo "Error: all flags are mutually exclusive"
          exit 1
        fi
        ;;
    u)  getConfiguredClient || exit 1
        checkInternet || exit 1
        update
        exit 0
        ;;
    :)  echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done

if [[ $# == "0" ]]; then
  usage
elif [[ $# == "1" ]]; then
  if [[ $1 == "clear" ]]; then
    clearAllTasks || exit 1
  elif [[ $1 == "update" ]]; then
    getConfiguredClient || exit 1
    checkInternet || exit 1
    update || exit 1
    exit 0
  elif [[ $1 == "help" ]]; then
    usage
    exit 0
  elif [[ $flag == "clear" || $1 == "clear" ]]; then clearAllTasks || exit 1
  elif [[ $flag == "get" || $1 == "list" || $1 == "get" ]]; then getTasks || exit 1
  else { echo "Error: the argument $1 is not valid"; exit 1; }; fi
else
  if [[ $flag == "add" || $1 == "add" ]]; then addTask "${*:2}" && getTasks || exit 1
  elif [[ $flag == "remove" || $1 == "remove" ]]; then removeTask "${*:2}" && getTasks || exit 1
  else { usage; exit 1; }; fi
fi
