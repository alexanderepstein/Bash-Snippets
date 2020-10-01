#!/usr/bin/env bash
# Author: Alexander Epstein https://github.com/alexanderepstein
# Author: Navan Chauhan https://github.com/navanchauhan

currentVersion="1.23.0"
configuredClient=""
configuredPython=""
APIKEY="b2f8880475c888056b6207067fbaa197"

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
  if  command -v python2 &>/dev/null ; then
    configuredPython="python2"
  elif command -v python &>/dev/null ; then
    configuredPython="python"
  else
    echo "Error: This tool requires python 2 to be installed."
    return 1
  fi
}

if [[ $(uname) != "Darwin" ]]; then
  python()
  {
    case "$configuredPython" in
      python2) python2 "$@";;
      python) python "$@";;
    esac
  }
fi

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
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
  elif [[ $latestVersion == "" ]];then
    echo "Error: no active internet connection" >&2
    exit 1
  else
    if [[ "$latestVersion" != "$currentVersion" ]]; then
      echo "Version $latestVersion available"
      echo -n "Do you wish to update $repositoryName [Y/n]: "
      read -r answer
      if [[ "$answer" == [Yy] ]]; then
        cd  ~ || { echo 'Update Failed' ; exit 1; }
        if [[ -d  ~/$repositoryName ]]; then rm -r -f $repositoryName || { echo "Permissions Error: try running the update as sudo"; exit 1; } ; fi
        git clone "https://github.com/$githubUserName/$repositoryName" || { echo "Couldn't download latest version" ; exit 1; }
        cd $repositoryName ||  { echo 'Update Failed' ; exit 1; }
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

printMovieInfo()
{
  echo
  echo "=========================================="
  echo "| Title: $name"
  echo "| Language: $language"
  echo "| Genre: $genres"
  echo "| Runtime: $runtime mins"
  echo "| User Rating: $voteAverage/10.0 with $voteCount votes"
  echo "| Plot: $plot"
  echo "=========================================="
  echo
}

usage()
{
  cat <<EOF
Movies
Description: Provides relevant information about a certain movie.
Usage: movies [flag] or movies [movieToSearch]
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Examples:
  movies Argo
  movies Inception
EOF
}

getMovieInfo()
{
  title=$1
  encodedTitle=$( echo "$title" | sed 's/ /%20/g' );
  movieSearchInfo=$( httpGet "https://api.themoviedb.org/3/search/movie?query=$encodedTitle&language=en-US&api_key=$APIKEY")
  movieID=$(echo "$movieSearchInfo" | python -c "import sys, json; print json.load(sys.stdin)['results'][0]['id']" 2> /dev/null)
  if [[ $movieID == "" ]];then { echo "Error: could not find a movie matching the title $title"; return 1; }; fi
  movieInfo=$(httpGet "https://api.themoviedb.org/3/movie/$movieID?api_key=$APIKEY")
  name=$(echo "$movieInfo" | python -c "import sys, json; print json.load(sys.stdin)['original_title']" 2> /dev/null )
  plot=$(echo "$movieInfo" | python -c "import sys, json; print json.load(sys.stdin)['overview']" 2> /dev/null )
  language=$(echo "$movieInfo" | python -c "import sys, json; print json.load(sys.stdin)['original_language']" 2> /dev/null )
  runtime=$(echo "$movieInfo" | python -c "import sys, json; print json.load(sys.stdin)['runtime']" 2> /dev/null )
  voteCount=$(echo "$movieInfo" | python -c "import sys, json; print json.load(sys.stdin)['vote_count']" 2> /dev/null )
  genreOne=$(echo "$movieInfo" | python -c "import sys, json; print json.load(sys.stdin)['genres'][0]['name']" 2> /dev/null )
  genreTwo=$(echo "$movieInfo" | python -c "import sys, json; print json.load(sys.stdin)['genres'][1]['name']" 2> /dev/null )
  genreThree=$(echo "$movieInfo" | python -c "import sys, json; print json.load(sys.stdin)['genres'][2]['name']" 2> /dev/null )
  genres=$(echo "$genreOne $genreTwo $genreThree" | tr " " ",")
  voteAverage=$(echo "$movieInfo" | python -c "import sys, json; print json.load(sys.stdin)['vote_average']" 2> /dev/null )
}

getConfiguredClient || exit 1
if [[ "$(uname)" == "Linux" ]];then getConfiguredPython || exit 1; fi
checkInternet || exit 1


while getopts 'uhv' flag; do
  case "${flag}" in
    u) update
       exit 0 ;;
    h) usage
       exit 0 ;;
    v) echo "Version $currentVersion"
       exit 0 ;;
    :) echo "Option -$OPTARG requires an argument." >&2
       exit 1 ;;
    *) exit 1 ;;
  esac
done

if [[ $# == 0 ]]; then
  usage
elif [[ $1 == "update" ]]; then
  update
elif [[ $1 == "help" ]]; then
  usage
else
  getMovieInfo "$@" || exit 1 ## exit if we return 1 (chances are movie was not found)
  printMovieInfo ## print out the data
fi
