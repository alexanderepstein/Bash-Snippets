#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein

currentVersion="1.23.0"
configuredClient=""
flagCount="0"
declare -a simpleOperations=(simplify factor derive integrate zeroes roots tangent area cos sin tan arccos arcsin arctan abs log)

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

validateExpression()
{
  local parsedExpression # only used here
  originalEquation=$(echo "$1" | sed "s/\[/\(/g" | sed "s/\]/\)/g") # accont for the fact that we have to use brackets and not parenthesis
  parsedExpression=$(echo "$1" | sed "s/\[/\(/g" | sed "s/\]/\)/g" | grep -Eo "[0-9 + -- / * ^ . a-z A-Z ~ : ( ) ]*") # only grepping valid characters
  if [ "$parsedExpression" != "$originalEquation" ];then { echo "Error: Expression contains invalid characters"; return 1; }; fi # compare result to original
  return 0
}

encodeEquation()
{
  equation=$(echo "$originalEquation" | sed "s:/:(over):g" | sed "s/~/|/g" | sed "s/-/%2D/g") # encode all the special characters
}

validateOperation()
{
  operation=$(echo "$1" | tr "[[:upper:]]" "[[:lower:]]") # get rid of case being an issue
  validOp="false" # lets us know if oeration is valid
  for op in "${simpleOperations[@]}"; do # go through all valid simple operations
    if [[ "$op" == "$operation" ]]; then { opType="simple"; validOp="true"; break; }; fi # if the operation matches leave the loop
  done
  if ! $validOp; then { echo "Error: invalid operation, run newton -h to get a list of valid operations"; return 1; }; fi # if not a valid operation error out
  if [[ $operation == "roots" ]]; then operation=zeroes;fi # I gave the ability to use root or zeores but real op is zeroes
}

getSimpleResponse()
{
  result=$(httpGet https://newton.now.sh/api/v2/$operation/"$equation" | grep -Eo '"result":"[a-z A-Z 0-9 ( ) \^ / -- + , ]*' | sed s/'"result":"'//g | tr '"' " ") # get reponse, grab result
  if [[ $result == "" ]];then { echo "Error: no result was returned, did you use valid characters?"; return 1; }; fi # if result is empty sometthing went wrong...
}

printAnswer()
{
  cat <<EOF
================================
|Operation: $operation
|Expression: $originalEquation
|Result: $result
================================
EOF
}


usage()
{
  cat <<EOF
Newton
Description: Performs numerical calculations all the way up to symbolic math parsing.
Usage: newton [optionalFlags] [operation] [expression] or newton [flag]
  -r  Only print the result, useful for piping output elsewhere
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
 ===================================================
|Operations     Sample Expression      Sample Result|
|---------------------------------------------------|
|Simplify       [[2x^2]+7]*[4x^2]    8 x^4 + 28 x^2 |
|Factor             x^2 + 2x             x (x + 2)  |
|Derive              x^2+2x               2 x + 2   |
|Integrate           x^2+2x         1/3 x^3 + x^2 +C|
|Roots/Zeroes        x^2+2x                2, 0     |
|Tangent             2~x^3              12 x + -16  | (Finding tangent line when x=2 for expression x^3)
|Area               2:4~x^3                 60      | (Finding area under curve from 2 to 4 for expression x^3)
|Cos                   pi                   -1      |
|Sin                   pi                    0      |
|Tan                  pi/4                   1      |
|ArcCos                 1                    0      |
|ArcSin                 0                    0      |
|ArcTan                pi                arcsin(pi) |
|Abs                   -2                    2      |
|Log                   2~8                   3      | (Log base 2 of eight)
 ===================================================
Valid Symbols:
  + add
  - subtract
  [ left parenthesis (you must use brackets bash has a bultin for parenthesis)
  ] right parenthesis (you must use brackets bash has a bultin for parenthesis)
  * multiply
  / divide
  ^ power
  : between the range of left and right side (only for area under curve)
  ~ parameter on right side (only for area, tangent line and log)
EOF
}


getConfiguredClient || exit 1

while getopts "ur:vh" opt; do
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
    u)  update
        exit 0
        ;;
    r)  resultOnly="true" && flagCount=$((flagCount + 1 ));;
    :)  echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done

if [[ $# == "0" ]]; then usage && exit 0
elif [[ $# == "1" ]]; then
  if [[ $1 == "update" ]]; then checkInternet && update && exit 0 || exit 1
  elif [[ $1 == "help" ]]; then usage && exit 0 || exit 1
  else echo "Error: newton needs two arguments, operation and expression" && exit 1;fi
elif [ $# -gt 3 ];then echo "Error: newton only accepts two arguments, operation and expression" && exit 1;fi

# flagCount helps us determine what argument to pass to the functions
# flow: validateOperation, validateExpression, encodeEquation, getResponse, print Answer/Result
checkInternet || exit 1
if [[ $flagCount == "0" ]];then validateOperation "$1" || exit 1
elif [[ $flagCount == "1" ]];then validateOperation "$2" || exit 1; fi
if [[ $flagCount == "0" ]];then validateExpression "$2" || exit 1
elif [[ $flagCount == "1" ]];then validateExpression "$3" || exit 1; fi
encodeEquation || exit 1
if [[ $opType == "simple" ]];then getSimpleResponse || exit 1;fi
if [ -z $resultOnly ];then printAnswer
else echo "$result"; fi
