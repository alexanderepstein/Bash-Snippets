#!/usr/bin/env bash
# Author: Navan Chauhan and Alexander Epstein
declare -a tools=(bak2dvd cheat cloudup crypt cryptocurrency currency geo lyrics meme movies newton pwned qrify short siteciphers stocks taste todo transfer weather ytview)
declare -a validTools=()
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

httpGet()
{
  case "$configuredClient" in
    curl)  curl -A curl -s "$@" ;;
    wget)  wget -qO- "$@" ;;
    httpie) http -b GET "$@" ;;
    fetch) fetch -q "$@" ;;
  esac
}

grablatestversion()
{
  repositoryName="Bash-Snippets"
  githubUserName="alexanderepstein"
  latestVersion=$(httpGet https://api.github.com/repos/$githubUserName/$repositoryName/tags | grep -Eo '"name":.*?[^\\]",'| head -1 | grep -Eo "[0-9.]+" ) #always grabs the tag without the v option
}

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

header()
{
  title="Bash Snippets"
  installver="Installed Version: $currentVersion"
  latestver="Latest Version: $latestVersion"
  printf "\t\t\t\t     %s\n" "$title"
  printf "\t\t%s\t\t%s\n" "$latestver" "$installver"
}


toolMenu()
{
  while true; do
    clear
    header
    count=1
    for command in "${validTools[@]}"; do
      if [[ $count -gt 9 ]];then c=$count
      else c="0$count"; fi
      spaces=$((40 - $(echo "$command" | wc -c)))
      echo -n -e "\t\t\t$c."
      for (( i = 0 ; i < $spaces; i++)) ;do
        printf " "
      done
      echo "$command"
      count=$(( $count + 1 ))
    done
    echo -e -n "\t\tChoose a tool or just press enter to go back: "
    read choice
    if [[ $choice == "" ]];then clear; header; break; fi
    echo -e -n "\t\tEnter any arguments you want to use with the tool: "
    read args
    clear
    if [[ $choice =~ [0-9] ]]; then ${validTools[$(($choice-1))]} "$args"
    else $choice "$args"; fi
    exit 0
  done
}

menu()
{
  while true; do
    echo -e "\t\t\t01.\t\t\t\tTools"
    echo -e "\t\t\t02.\t\t\t\tInstallation Check"
    echo -e "\t\t\t03.\t\t\t\tView man page"
    echo -e "\t\t\t04.\t\t\t\tUpdate"
    echo -e "\t\t\t05.\t\t\t\tDonate"
    echo -e "\t\t\t06.\t\t\t\tQuit"
    echo -e -n "\n\t\t\tChoose an option: "
    read choice
    if [[ $choice -gt 6 || $choice -lt 1 ]];then
      echo "Error invalid option!"
      sleep 2
      clear
      header
      continue
    fi
    clear
    header
    if   [[ $choice -eq 1 ]];then toolMenu
    elif [[ $choice -eq 2 ]];then installationcheck
    elif [[ $choice -eq 3 ]];then man bash-snippets
    elif [[ $choice -eq 4 ]];then
      ${validTools[1]} -u
      sleep 2
      clear
      header
    elif [[ $choice -eq 5 ]];then
      clear
      echo -e "\t\tThanks for thinking of donating, that's pretty cool of you"
      echo -e "\n\t\tCryptocurrency Donation Addresses"
      echo -e "\t\t\tBTC: 38Q5VbH63MtouxHu8BuPNLzfY5B5RNVMDn"
      echo -e "\t\t\tETH: 0xf7c60C06D298FF954917eA45206426f79d40Ac9D"
      echo -e "\t\t\tLTC: LWZ3T19YUk66dgkczN7dRhiXDMqSYrXUV4\n"
      echo -e "\t\tNormal Methods"
      echo -e "\t\t\tVenmo: AlexanderEpstein"
      echo -e "\t\t\tSquare Cash: AlexEpstein\n\n\n\n"
      exit 0
    elif [[ $choice -eq 6 ]]; then clear; exit 0
    fi
  done
}

installationcheck()
{
  validTools=()
  for tool in "${tools[@]}"; do
    if [ -e "/usr/local/bin/$tool" ]; then
      state="present";
      start=51;
      validTools+=($tool);
    else state="absent"; start=52; fi
      if $1; then
        echo -n -e "\t\t$tool"
        spaces=$(($start - $( echo "$tool" | wc -c)))
        for (( i = 0 ; i < $spaces; i++)) ;do
          printf " "
        done
        echo $state
      fi
  done
  if $1; then
    echo -n "Press enter to go back to the menu"
    read
    clear
    header
  fi
}

if [[ $# -eq 0 ]]; then
  clear
  checkInternet
  getConfiguredClient
  grablatestversion
  header
  installationcheck false
  echo
  menu
elif [[ $# -eq 1 ]]; then
  if [[ $1 == "-u" || $1 == "update" ]]; then
    installationcheck false
    ${validTools[1]} -u
  elif [[ $1 == "-h" || $1 == "help" ]]; then man bash-snippets
  elif [[ $1 == "-v" ]]; then echo "Version $currentVersion"
  fi

fi
