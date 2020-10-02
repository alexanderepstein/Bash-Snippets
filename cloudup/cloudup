#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein

currentVersion="1.23.0"
configuredClient=""
private="0" ## state of private flag
all="0" ## state of all flag
if [ -d ~/temp ]; then rm -rf ~/temp; fi ## if the temp folder exists we want to delete it just in case it was left over from a fatal error
source="0"
tStamp="0"


## This function determines which http get tool the system has installed and returns an error if there isnt one
getConfiguredClient()
{
  if  command -v curl &>/dev/null; then
    configuredClient="curl"
  elif command -v wget &>/dev/null; then
    configuredClient="wget"
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

## This grabs the users bitbucket info could be improved by making sure username exists
getBitbucketInfo()
{
  echo -n 'Enter your Bitbucket username: '
  read bbUsername
  if [[ $bbUsername == "1" ]]; then
    echo  "Using github username as bitbucket username"
    bbUsername=$ghUsername
  fi
  echo -n 'Enter your Bitbucket password: '
  read -s password  # -s flag hides password text;
  echo
  echo
}

backupRepo()
{
  cd ~/temp/github/"$repoName" || { echo "Fatal error"; return 1; }
  repoSlug=$(echo "$repoName" | tr '[:upper:]' '[:lower:]')
  if [[ $tStamp == "0" ]]; then { echo -n "Attempting to delete existing bitbucket repostiory..."; httpGet -X DELETE "https://$bbUsername:$password@api.bitbucket.org/1.0/repositories/$bbUsername/$repoSlug" > /dev/null || echo -n -e "Failure!\n"; echo -n -e "Success!\n"; }; fi ## if no timestamp then repo will not be unique we must look to delete old repo
  if [[ $private == "1" ]]; then
    echo -n "Creating private repository for $repoName..."
  else
    echo -n "Creating public repository for $repoName..."
  fi
  if [[ $tStamp == "1" ]]; then ## create the repository with a timestamp appended to repo name
    timestamp=$(date | tr " " _ | tr : _  ) ## we do this because it takes care of changes bitbucket would have made
    if [[ $private == "1" ]]; then # if so we will use --data is_private=true when creating repository
      httpGet --user "$bbUsername":"$password" https://api.bitbucket.org/1.0/repositories/ --data name="$repoName""$timestamp" --data is_private=true > /dev/null || { echo -n -e "Failure!\n"; echo "Error: creating the bitbucket repo failed, most likely due to an incorrect username or password."; return 1; }
    else
      httpGet --user "$bbUsername":"$password" https://api.bitbucket.org/1.0/repositories/ --data name="$repoName""$timestamp" > /dev/null || { echo -n -e "Failure!\n"; echo "Error: creating the bitbucket repo failed, most likely due to an incorrect username or password."; return 1; }
    fi
    echo -n -e "Success!\n"
    echo -n "Setting new remote url..."
    git remote set-url origin "https://$bbUsername:$password@bitbucket.org/$bbUsername/$repoName$timestamp.git" > /dev/null || { echo -n -e "Failure!\n"; return 1;} ## switch the remote over to bitbucket rather than github
  else # we are creating a reoo without a timestamp appended name
    if [[ $private == "1" ]]; then # if so we will use --data is_private=true when creating repository
      httpGet --user "$bbUsername":"$password" https://api.bitbucket.org/1.0/repositories/ --data name="$repoName" --data is_private=true > /dev/null || { echo -n -e "Failure!\n"; echo "Error: creating the bitbucket repo failed, most likely due to an incorrect username or password."; return 1; }
    else
      httpGet --user "$bbUsername":"$password" https://api.bitbucket.org/1.0/repositories/ --data name="$repoName" > /dev/null || { echo -n -e "Failure!\n"; echo "Error: creating the bitbucket repo failed, most likely due to an incorrect username or password."; return 1; }
    fi
    echo -n -e "Success!\n"
    echo -n "Setting new remote url..."
    git remote set-url origin "https://$bbUsername:$password@bitbucket.org/$bbUsername/$repoName.git" > /dev/null || { echo -n -e "Failure!\n"; return 1;} ## switch the remote over to bitbucket rather than github
    echo -n -e "Success!\n"
  fi
  echo -n "Uploading $repoName to bitbucket.."

  git push -q  origin --all > /dev/null && touch ~/temp/github/.BSnippetsHiddenFile || { echo -n -e "Failure!\n"; touch -f ~/temp/github/.BSnippetsBrokenFile; return 1; } & ## pushes al files to github and most of the repo history
  while [[ ! -f ~/temp/github/.BSnippetsHiddenFile ]] ;do if [ -f ~/temp/github/.BSnippetsBrokenFile ];then return 1;fi && echo -n "." && sleep 2; done
  rm -f ~/temp/github/.BSnippetsHiddenFile
  echo -e -n "Success!\n"
  echo -n "Uploading the tags for $repoName.."
  git push -q origin --tags > /dev/null && touch ~/temp/github/.BSnippetsHiddenFile || { echo -n -e "Failure!\n"; touch -f ~/temp/github/.BSnippetsBrokenFile; return 1; } & ## have to push tags here since --tags and --all are mutually exclusive
  while [[ ! -f ~/temp/github/.BSnippetsHiddenFile ]] ;do if [ -f ~/temp/github/.BSnippetsBrokenFile ];then return 1;fi && echo -n "." && sleep 2; done
  rm -f ~/temp/github/.BSnippetsHiddenFile
  echo -e -n "Success!\n"
  rm -rf ~/temp #if we have succesfully backedup the repo we dion't need this anymore and if we do we will recreate it
  echo "Successfully backed up $repoName"
}

## When cloudup is called with no flags
getGitHubRepoInfo()
{
  echo -n 'Enter the name of the repostiory to backup: '
  read repoName
}

## This grabs github user info could be improved upon by checking if user exists
getGitHubUserInfo()
{
  echo -n 'Enter your Github username: '
  read ghUsername
}

## function that handles cloning a repository it uses $ghUsername and $repoName
cloneGitHubRepo()
{
  echo -n "Cloning $repoName.."
  validRepo="false"
  for repo in "${repoNames[@]}"; do
    if [[ $repo == "$repoName" ]];then validRepo="true" && break; fi
  done
  if ! $validRepo;then { echo -n -e "Failure!\n"; echo "Github repostiory is not valid (either incorrect username or repository)"; return 1;}; fi
  mkdir ~/temp
  cd || { echo "Fatal error"; return 1; }
  mkdir ~/temp/github || { echo "Fatal error"; return 1; }
  cd ~/temp/github || { echo "Fatal error"; return 1; }
  git clone -q  https://github.com/"$ghUsername"/"$repoName" && touch ~/temp/github/.BSnippetsHiddenFile || { touch ~/temp/github/.BSnippetsBrokenFile; echo -e -n "Failure!\n"; return 1;} &
  while [[ ! -f ~/temp/github/.BSnippetsHiddenFile ]] ;do if [ -f ~/temp/github/.BSnippetsBrokenFile ];then return 1;fi && echo -n "." && sleep 2; done
  rm -f ~/temp/github/.BSnippetsHiddenFile
  echo -n -e "Success!\n"
}

## Grabs the last 100 updated repos and greps to grab the repository names and puts them in an array called repoNames
getGithubRepoNames()
{
  for pageNumber in {1..100}; do ## iterate through 100 possible pages
    response=$(httpGet "https://api.github.com/users/$ghUsername/repos?sort=updated&per_page=100&page=$pageNumber") ## grab the original response
    if [[ $pageNumber == "1" && ( $(echo "$response" | grep -Eo "Not Found") == "Not Found"  || $response == "[' ']") ]];then  { echo -e -n "Failure!"; echo "Github username is invalid"; return 1;};fi
    repoResponse=$(echo "$response" | grep -Eo '"full_name": "[ a-Z .  \/ \\ 0-9 -- _ ]*' | sed  s/'"full_name": "'/""/g | sed s:"$ghUsername"/:: ) ## extract the repo names from the response
    forkResponse=($(echo "$response" | grep -Eo '"fork": [a-Z]*' | cut -d " " -f 2 | sed  s/"'"//g  )) ## extract the fork status of each repo
    count=0  ## used to iterate through the fork statuses
    if [[ $repoResponse == "" ]]; then break; fi ## will only break if the page is empty
    for repo in $repoResponse; do ## go through each repo
      if [[ $source == "1" ]]; then ## if the user set the source flag
        if [[ ${forkResponse[$count]} == "false" ]]; then repoNames+=("$repo"); fi ## if they are the owner of the repository add it to the list of repoNames
        count=$(( $count + 1 )) ## increment the counter
      else ## the user didnt set the source flag
        repoNames+=("$repo") ## add all repos in repoResponse to repoNames
      fi
    done
  done
}

usage()
{
  cat <<EOF
Cloudup
Description: Backs up a users github repositories to your bitbucket account.
  With no flags cloudup will guide you through backing up a single repository
Usage: cloudup [flags] or cloudup [flags] [listOfGHRepoNamesSplitBySpaces]
  -p  Upload the repositor(y)(ies) as private to bitbucket (must have private
      repo ability on bitbucket)
  -a  Backup all github repositories
  -s  Only backup repositories that you have created (no forks) (only works in
      conjunction with the -a flag)
  -t  Backup the repository with a timestamp added to the repostiory name (will
      always create a new unique bitbucket repo)
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Examples:
  cloudup
  cloudup -p -a
  cloudup -a -s
  cloudup -t
  cloudup -a -s -t -p
  cloudup -p nameOfRepo1 nameOfRepo2
  cloudup nameOfRepo
  cloudup -a
EOF
}

getConfiguredClient || exit 1


while getopts "tspauvh" opt; do
  case "$opt" in
    \?) echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    s)  source="1"  ;;
    p)  private="1" ;;
    t)  tStamp="1"  ;;
    h)  usage
        exit 0
        ;;
    a)  all="1" ;;
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

if [[ $source == "1" && $all == "0" ]]; then { echo "Error: the -s flag only works in conjunction with the -a flag."; exit 1; }; fi ## check if the source flag was used correctly (no need to have source flag when specifying the repositories)
if [[ $configuredClient != "curl" ]]; then { echo "Error: to use cloudup without the -t option curl must be installed"; exit 1; }; fi ## we have to have the ability to delete an unique repo which is possible with curl -X DELETE
if [[ $# == "1" ]]; then # check for keywords
  if [[ $1 == "update" ]]; then
    checkInternet || exit 1
    update
    exit 0
  elif [[ $1 == "help" ]]; then
    usage
    exit 0
  fi
fi

checkInternet || exit 1
if [[ $all == "0" ]]; then
  if [[ ($private == "0" && $tStamp == "0" && $1 != "")]]; then ## checking for an arguments after possible flags if so then run through the arguments (repositories) and back them up
    getGitHubUserInfo || exit 1
    getGithubRepoNames || exit 1
    getBitbucketInfo || exit 1
    for i in "$@"; do ## if private is not on as a flag start rpping through them
      repoName=$i
      echo "Starting to backup $repoName"
      cloneGitHubRepo || exit 1
      backupRepo || { echo "Error: couldnt backup $repoName to bitbucket"; exit 1; }
      echo
    done
    exit 0
  elif [[ ( $private == "0" && $tStamp == "0" &&  $1 == "" ) || ( $private == "1" && $tStamp == "0" && $2 == "" ) || ( $private == "0" && $tStamp == "1" && $2 == "" ) || ( $private == "1" && $tStamp == "1" && $3 == "" )  ]]; then ## check for empty arguments after all possible flags, this will intiate a guided backup
    getGitHubUserInfo || exit 1
    getGithubRepoNames || exit 1
    getGitHubRepoInfo || exit 1
    getBitbucketInfo || exit 1
    echo
    cloneGitHubRepo || exit 1
    backupRepo || { echo "Error: couldnt backup $repoName to bitbucket"; exit 1; }
    exit 0
  else ## flags are set but arguments are also provided
    firstArg=$(( $private + $tStamp + 1 ))
    getGitHubUserInfo || exit 1
    getGithubRepoNames || exit 1
    getBitbucketInfo || exit 1
    for i in "${@:$firstArg}"; do
      repoName=$i
      echo "Starting to backup $repoName"
      cloneGitHubRepo || exit 1
      backupRepo || { echo "Error: couldnt backup $repoName to bitbucket"; exit 1; }
      echo
    done
    exit 0
  fi
else
  getGitHubUserInfo || exit 1
  getGithubRepoNames || exit 1
  getBitbucketInfo || exit 1
  echo
  for repo in "${repoNames[@]}"; do
    repoName=$repo
    echo "Starting to backup $repoName"
    cloneGitHubRepo || exit 1
    backupRepo  || { echo "Error: couldnt backup $repoName to bitbucket"; exit 1; }
    echo
  done
  echo "Successfully backed up all repositories"
  exit 0
fi
