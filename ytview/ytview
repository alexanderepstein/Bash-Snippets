#!/usr/bin/env bash
# Author: Linyos Torovoltos https://github.com/linyostorovovoltos
# Modifications: Alexander Epstein https://github.com/alexanderepstein

if [[ -d $HOME/.cache/ytview ]]; then rm -rf "$HOME"/.cache/ytview/; fi

player=""
configuredClient=""
currentVersion="1.23.0"
flag=""

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
    echo "Error: This tool requires either curl, wget, httpie or fetch to be installed\." >&2
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

getConfiguredPlayer()
{
  if [ ! -z "${YTVIEWPLAYER+x}" ]; then
    player="$YTVIEWPLAYER"
    return 0
  fi
  if [[ $(uname -s) == "Linux" ]]; then
    if command -v vlc &>/dev/null; then
      player="vlc"
    elif command -v mpv &>/dev/null; then
      player="mpv"
    elif command -v mplayer &>/dev/null; then
      player="mplayer"
    else
      echo "Error: no supported video player installed (vlc, mpv or mplayer)" >&2
      return 1
    fi
  elif [[ $(uname -s) == "Darwin" ]]; then
    if [[ -f /Applications/VLC.app/Contents/MacOS/VLC ]]; then
      player="/Applications/VLC.app/Contents/MacOS/VLC"
    elif [[ -f $HOME/Applications/VLC.app/Contents/MacOS/VLC ]]; then
      player="$HOME/Applications/VLC.app/Contents/MacOS/VLC"
    elif command -v mpv &>/dev/null; then
      player="mpv"
    elif [[ -f /Applications/mpv.app/Contents/MacOS/mpv ]]; then
      player="/Applications/mpv.app/Contents/MacOS/mpv"
    elif [[ -f $HOME/Applications/mpv.app/Contents/MacOS/mpv ]]; then
      player="$HOME/Applications/mpv.app/Contents/MacOS/mpv"
    else
	  if [[ $(mdutil -s / | grep "Indexing enabled." 2>/dev/null) != "" ]]; then
	    vlc_md=$(mdfind kMDItemCFBundleIdentifier = "org.videolan.vlc" 2>/dev/null)
	    if [[ $vlc_md != "" ]]; then
	      player="$vlc_md/Contents/MacOS/VLC"
	    else
	      mpv_md=$(mdfind kMDItemCFBundleIdentifier = "io.mpv" 2>/dev/null)
	      if [[ $mpv_md != "" ]]; then
	        player="$mpv_md/Contents/MacOS/mpv"
	      else
	        echo "Error: no supported video player installed (VLC or mpv)" >&2
	        return 1
	      fi
	    fi
	  else
	    echo "Error: no supported video player installed (VLC or mpv)" >&2
	    return 1
	  fi
    fi
  fi
}

# Get the video titles
channelview()
{
  mkdir -p "$HOME"/.cache/ytview/channels/"$channel" || return 1
  httpGet "https://www.youtube.com/user/$channel/videos?hl=en" | grep "Duration" | awk '{print $10 " " $11 " " $12 " " $13 " " $14 " " $15 " " $16 " " $17 " " $18 " " $19 " " $20 " " $21 " " $22 " " $23 " " $24 " " $25 " " $26 " " $27 " " $29}' | sed 's/aria-describedby="description-id.*//' | sed s/title=// | sed 's/"//' | sed 's/"//' | awk '{printf "%s.\t%s\n",NR,$0}'  | sed  s/'&#39;'/"'"/g | sed s/'&amp;'/'and'/g | sed s/\&quot\;/\"/g > "$HOME"/.cache/ytview/channels/"$channel"/titles.txt || return 1

  # Get the video urls
  httpGet "https://www.youtube.com/user/$channel/Videos?hl=en" | grep "watch?v=" | awk '{print $6}' | sed s/spf-link// | sed s/href=// | sed 's/"//' | sed 's/"//' | sed '/^\s*$/d' | sed 's/\//https:\/\/www.youtube.com\//' | awk '{printf "%s.\t%s\n",NR,$0}' > "$HOME"/.cache/ytview/channels/"$channel"/urls.txt || return 1

  # Print 20 first video titles for the user to choose from
  head -n 20 "$HOME"/.cache/ytview/channels/"$channel"/titles.txt || return 1
  # Prompt the user for video number
  read -p "Choose a video: " titlenumber
  if [[ -n ${titlenumber//[0-9]/} ]]; then
    echo "Canceled." >&2
    exit 0
  fi

  # Play the video with your player
  $player $(sed -n $(echo "$titlenumber")p < "$HOME"/.cache/ytview/channels/"$channel"/urls.txt | awk '{print $2}') > /dev/null 2>&1 &
}

searchview()
{
  search=$(echo "$search" | tr " " + )
  mkdir -p "$HOME"/.cache/ytview/searches/"$search"

  #Get video titles
  httpGet "https://www.youtube.com/results?hl=en&search_query=$search" | grep "Duration" | grep "watch?v=" | awk '{print $13 " " $14 " " $15 " " $16 " " $17 " " $18 " " $19 " " $20 " " $21 " " $22 " " $23 " " $23}' | sed 's/aria-describedby="description-id.*//g' | sed s/title=// | sed 's/"//g' | sed s/spf-link// | sed 's/data-session-link=itct*.//' | sed s/spf-prefetch//g | sed 's/rel=//g' | sed 's/"//' | awk '{printf "%s.\t%s\n",NR,$0}' | sed  s/'&#39;'/"'"/g | sed  s/'&amp;'/'and'/g | sed s/\&quot\;/\"/g > "$HOME"/.cache/ytview/searches/"$search"/titles.txt || return 1

  #Get video urls
  httpGet "https://www.youtube.com/results?hl=en&search_query=$search" | grep "watch?v=" | awk '{print $5}' | sed s/vve-check// | sed 's/href="/https:\/\/www.youtube.com/' | sed 's/"//' | sed s/class="yt-uix-tile-link"// | sed '/^\s*$/d' | awk '{printf "%s.\t%s\n",NR,$0}' > "$HOME"/.cache/ytview/searches/"$search"/urls.txt || return 1
  #Print 20 first video titles for the user to choose from
  cat "$HOME"/.cache/ytview/searches/"$search"/titles.txt || return 1

  #Let the user choose the video number
  read -p "Choose a video: " titlenumber
  if [[ -n ${titlenumber//[0-9]/} ]]; then
    echo "Canceled." >&2
    exit 0
  fi

  #Play the video with your favorite player
  $player $(sed -n $(echo "$titlenumber")p < "$HOME"/.cache/ytview/searches/"$search"/urls.txt | awk '{print $2}') > /dev/null 2>&1 &
}

usage()
{
  cat <<EOF
Ytview
Description: Search and play youtube videos right from the terminal.
Usage: ytview [flag] [string] or ytview [videoToSearch]
  -s  Searches youtube
  -c  Shows the latest videos of a channel
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
Examples:
  ytview -s Family Guy Chicken Fight
  ytview -c Numberphile
EOF
}

getConfiguredClient || exit 1


while getopts "vuc:s:h*:" option; do
  case "${option}" in
    s) if [[ $flag != "channel" ]]; then
         search=$(printf '%s ' "$@")
         flag="search"
       else
         echo "Error: search and channel options are mutually exclusive" >&2
         exit 1
       fi
        ;;
    c) if [[ $flag != "search" ]]; then
         channel="$OPTARG"
         flag="channel"
       else
         echo "Error: search and channel options are mutually exclusive" >&2
         exit 1
       fi
       ;;
    h) usage && exit 0 ;;
    u) checkInternet && update && exit 0 || exit 1;;
    v) echo "Version $currentVersion" && exit 0 ;;
    *) usage && exit 0 ;;
  esac
done

if [[ $# == "0" ]]; then
  usage
  exit 0
elif [[ $1 == "help" ]]; then
  usage
  exit 0
elif [[ $1 == "update" ]]; then
  checkInternet || exit 1
  update
  exit 0
elif [[ $flag == "search" ]]; then
  checkInternet || exit 1
  getConfiguredPlayer || exit 1
  searchview || exit 1
elif [[ $flag == "channel" ]]; then
  checkInternet || exit 1
  getConfiguredPlayer || exit 1
  channelview || exit 1
else
  checkInternet || exit 1
  search=$(printf '%s ' "$@")
  getConfiguredPlayer || exit 1
  searchview || exit 1
fi
