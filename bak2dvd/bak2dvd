#!/usr/bin/env bash
# Author: Charles Oblender https://github.com/oblende
currentVersion="1.23.0"
configuredClient=""

tarwrite() {
	tl=$1
	pn=$2
	tops=$3
	# FreeBSD needs to use gtar
	# Make this a function for the addition of a restore option
    	# These if statements test for all possible combinations of null strings and executes the permutation
    	# of tar or gtar that excludes the null string.
		if command -v gtar &>/dev/null
		then
            if [[ -z "$tops" && -n "$dir" && -n "$excludes" ]]
            then
                gtar -cvpML "$tl" -f "$pn" "${dir[@]}" "${excludes[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=2
                return
            elif [[ -n "$tops" && -z "$dir" && -n "$excludes" ]]
            then
                gtar -cvpML "$tl" -f "$pn" "$tops" "${excludes[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=2
                return
	    elif [[ -n "$tops" && -n "$dir" && -z "$excludes" ]]
	    then
                gtar -cvpML "$tl" -f "$pn" "$tops" "${dir[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=2
                return
	    elif [[ -n "$tops" && -z "$dir" && -n "$excludes" ]]
	    then
                gtar -cvpML "$tl" -f "$pn" "$tops" "${excludes[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=2
                return
	    elif [[ -n "$tops" && -z "$dir" && -z "$excludes" ]]
	    then
                gtar -cvpML "$tl" -f "$pn" "$tops" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=2
                return
	    elif [[ -z "$tops" && -z "$dir" && -n "$excludes" ]]
	    then
                gtar -cvpML "$tl" -f "$pn" "${excludes[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=2
                return
	    elif [[ -z "$tops" && -z "$dir" && -z "$excludes" ]]
	    then
                gtar -cvpML "$tl" -f "$pn" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=2
                return
	    else
                gtar -cvpML "$tl" -f "$pn" "$tops" "${dir[@]}" "${excludes[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=2
                return
	    fi
    fi

	if command -v tar &>/dev/null
        then
            if [[ -z "$tops" && -n "$dir" && -n "$excludes" ]]
            then
                tar -cvpML "$tl" -f "$pn" "${dir[@]}" "${excludes[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=1
                return
            elif [[ -n "$tops" && -z "$dir" && -n "$excludes" ]]
            then
                tar -cvpML "$tl" -f "$pn" "$tops" "${excludes[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=1
                return
	    elif [[ -n "$tops" && -n "$dir" && -z "$excludes" ]]
	    then
                tar -cvpML "$tl" -f "$pn" "$tops" "${dir[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=1
                return
	    elif [[ -n "$tops" && -z "$dir" && -n "$excludes" ]]
	    then
                tar -cvpML "$tl" -f "$pn" "$tops" "${excludes[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=1
                return
	    elif [[ -n "$tops" && -z "$dir" && -z "$excludes" ]]
	    then
                tar -cvpML "$tl" -f "$pn" "$tops" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=1
                return
	    elif [[ -z "$tops" && -z "$dir" && -n "$excludes" ]]
	    then
                tar -cvpML "$tl" -f "$pn" "${excludes[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=1
                return
	    elif [[ -z "$tops" && -z "$dir" && -z "$excludes" ]]
	    then
                tar -cvpML "$tl" -f "$pn" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=1
                return
	   else
                tar -cvpML "$tl" -f "$pn" "$tops" "${dir[@]}" "${excludes[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=1
        fi
    fi


}

tarread() {
	pn=$1
	tops=$2
    # These if statements test for null strings and then excutes the permutation of tar or gtar
    # that excludes the null strings.
	if command -v gtar &>/dev/null
	then
            if [[ -n "$tops" && -n "$dir" && -z "$filenames" ]]
            then
                gtar -xvpMf "$pn" "$tops" "${dir[@]}" <&7 &
                tarpid=$!
                countlimit=2
                return
            elif [[ -n "$tops" && -z "$dir" && -n "$filenames" ]]
            then
                gtar -xvpMf "$pn" "$tops" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=2
                return
			elif [[ -n "$tops" && -z "$dir" && -z "$filenames" ]]
            then
                gtar -xvpMf "$pn" "$tops" <&7 &
                tarpid=$!
                countlimit=2
                return
			elif [[ -z "$tops" && -n "$dir" && -n "$filenames" ]]
            then
                gtar -xvpMf "$pn" "${dir[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=2
                return
			elif [[ -z "$tops" && -n "$dir" && -z "$filenames" ]]
            then
                gtar -xvpMf "$pn" "${dir[@]}" <&7 &
                tarpid=$!
                countlimit=2
                return
			elif [[ -z "$tops" && -z "$dir" && -n "$filenames" ]]
            then
                gtar -xvpMf "$pn" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=2
			return
			elif [[ -z "$tops" && -z "$dir" && -z "$filenames" ]]
            then
                gtar -xvpMf "$pn" <&7 &
                tarpid=$!
                countlimit=2
                return
			else
                gtar -xvpMf "$pn" "$tops" "${dir[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=2
			return
		fi
    fi

		if command -v tar &>/dev/null
		then
		if [[ -n "$tops" && -n "$dir" && -z "$filenames" ]]
            then
                tar -xvpMf "$pn" "$tops" "${dir[@]}" <&7 &
                tarpid=$!
                countlimit=1
                return
            elif [[ -n "$tops" && -z "$dir" && -n "$filenames" ]]
            then
                tar -xvpMf "$pn" "$tops" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=1
                return
			elif [[ -n "$tops" && -z "$dir" && -z "$filenames" ]]
            then
                tar -xvpMf "$pn" "$tops" <&7 &
                tarpid=$!
                countlimit=1
                return
			elif [[ -z "$tops" && -n "$dir" && -n "$filenames" ]]
            then
                tar -xvpMf "$pn" "${dir[@]}" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=1
                return
			elif [[ -z "$tops" && -n "$dir" && -z "$filenames" ]]
            then
                tar -xvpMf "$pn" "${dir[@]}" <&7 &
                tarpid=$!
                countlimit=1
                return
			elif [[ -z "$tops" && -z "$dir" && -n "$filenames" ]]
            then
                tar -xvpMf "$pn" "${filenames[@]}" <&7 &
                tarpid=$!
                countlimit=1
			return
			elif [[ -z "$tops" && -z "$dir" && -z "$filenames" ]]
            then
                tar -xvpMf "$pn" <&7 &
                tarpid=$!
                countlimit=1
                return
	    else
		 tar -xvpMf "$pn" "$tops" "${dir[@]}" "{$filenames[@]}" <&7 &
             	tarpid=$!
             	countlimit=1
	    fi
    fi
}

discread() {
	dev=$1
	pn=$2
	tpid=$3
	counter=$4
	countlim=$5
	rl=$6
    # FreeBSD is a brain damaged OS written by brain damaged developers who, when given a choice, will run headlong into
    # making a task or operation as difficult as possible.
    if [[ $(uname | grep "FreeBSD" | wc -l) -gt 0 ]]
    then
        while [ "$counter" -eq "$countlim" ]
        do
            dd if="$dev" of="$pn" bs=2048
            eject "$dev"
            counter=0
            counter=$(ps -A | grep $tarpid | wc -l)
            if [[ $counter -eq $countlim ]]
            then
                echo
                read -p "Insert next disc and press Enter:" response
                echo "$response" >&7
            fi
        done
    else
        while [ "$counter" -eq "$countlim" ]
        do
            dd if="$dev" of="$pn" bs=1k count="$rl"
            eject "$dev"
            counter=0
            counter=$(ps -A | grep $tarpid | wc -l)
            if [[ $counter -eq $countlim ]]
            then
                read -p "Insert next disc and press Enter:" response
                echo "$response" >&7
            fi
        done
    fi
}

dvdburn() {
	counter=$4
	countlim=$5
	altburn=$6
	while [ "$counter" -eq "$countlim" ]
	do
		if [[ $(echo "$1" | grep "dev" | wc -l) -eq 0 ]]
		then
			echo "DVD or BluRay burning requires device from /dev."
			exitcode=1
			cleanup $exitcode
		fi
		# Growisofs is untrustworthy for DL media, and is slow for BD-RE/DVD-RAM media because of defect management.
			case "$altburn" in
				cdrskin)
                    			# cdrskin doesn't like -multi when burning BD-R media.
					# BD-RE media needs to be formatted before recording
					cdrskin dev="$1" blank=as_needed stream_recording=on driveropts=burnfree -tao -eject -data "$2"
					;;
				xorrecord)
					xorrecord dev="$1" blank=as_needed stream_recording=on driveropts=burnfree -tao -multi -eject -data "$2"
					;;
				*)
					growisofs -Z "$1"="$2"
			esac
        	counter=0
        	counter=$(ps -A | grep "$3" | wc -l)
        	if [[ $counter -eq $countlim ]]
        	then
                	read -p "Insert next disc and press Enter:" response
                	echo "$response" >&7
        	fi
	done
# dvd-r restore needs tracklen + 4. Need to check +r single and dual layer as well as bd medias. Joy.
# DVD+R needs no compensation.
}

cdburn() {
	counter=$4
	countlim=$5
	cdb=$6
	while [ "$counter" -eq "$countlim" ]
	do
		if [[ $(uname | grep "FreeBSD" | wc -l) -gt 0 ]]
		then
			if [[ $(echo "$1" | grep "dev" | wc -l) -gt 0 && $(echo "$cdb" | grep "cdrecord" | wc -l) -gt 0 ]]
			then
				echo "CD burning requires SCSI address in the form of b,t,l. Please use cdrecord -scanbus for a list of possible SCSI addresses."
				exitcode=1
				cleanup $exitcode
			fi
		elif [[ $(uname | grep "Linux" | wc -l) -gt 0 ]]
		then
			if [[ $(echo "$1" | grep "dev" | wc -l) -eq 0 ]]
			then
				# Chances are if it's Linux then wodim is being used and requires /dev/srX instead of SCSI address
				echo "CD burning in Linux with cdrecord or wodim requires device from /dev."
				exitcode=1
				cleanup $exitcode
			fi
		fi
		case "$cdb" in
			cdrecord)
				cdrecord dev="$1" driveropts=burnfree -tao -multi -eject -data "$2" #Turned burnfree on just in case. Restore needs tracklen + 8
				;;
			wodim)
				wodim dev="$1" driveropts=burnfree -tao -multi -eject -data "$2"
				;;
			cdrskin)
				cdrskin dev="$1" driveropts=burnfree -tao -multi -eject -data "$2"
				;;
			xorrecord)
				xorrecord dev="$1" driveropts=burnfree -tao -multi -eject -data "$2"
				;;
		esac

		counter=0
		counter=$(ps -A | grep "$3" | wc -l)
		if [[ $counter -eq $countlim ]]
		then
			read -p "Insert next disc and press Enter:" response
			echo "$response" >&7
		fi
	done
}

cleanup() {
	kill $tarpid &>/dev/null
	rm "$pipename"
	rm "$fifoname"

	exit "$1"
}

getCDburner() {

	if command -v cdrecord &>/dev/null
	then
		cdburner="cdrecord"
		return
	fi
	if command -v wodim &>/dev/null
	then
		cdburner="wodim"
		return
	fi
	if command -v cdrskin &>/dev/null
	then
		cdburner="cdrskin"
		return
	fi
	if command -v xorrecord &>/dev/null
	then
		cdburner="xorrecord"
		return
	fi

}
# This function finds an alternative burner to growisofs if DVD-DL, DVD-RAM, or BD-R(E) media is chosen to improve speed
# or to actually write a full dataset in the case of DVD-DL media.
getAltDVDburner() {

	if command -v cdrskin &>/dev/null
	then
		altdvdburner="cdrskin"
		return
	fi
	if command -v xorrecord &>/dev/null
	then
		altdvdburner="xorrecord"
		return
	else
        echo "To burn DVD-DL or BD media xorriso or cdrskin needs to be installed."
        echo "I can burn using growisofs, but it may not burn DVD-DL media correctly or will burn BD-RE media very slowly."
        read -p "If you wish to continue using growisofs then type YES then press [Enter], else just press [Enter] to abort: " yesno
        if [[ "$yesno" -eq "YES" ]]
        then
            if command -v growisofs &>/dev/null
            then
                altdvdburner="growisofs"
            fi
        else
            exitcode=1
            cleanup $exitcode
        fi
    fi
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
        git clone "https://github.com/$githubUserName/$repositoryName" || { echo "Couldn't download latest version"; exit 1; }
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

usage()
{
  cat <<EOF
Bak2dvd
Description: A script to write tar archives to optical disc.
Usage: bak2dvd [flags] -t "[arguments]"
  -u  Update Bash-Snippet Tools
  -h  Show the help
  -v  Get the tool version
  -d  Sets the optical drive to use
  -C Change to directory
  -a Include file or directory into archive
  -t  Parameters to pass to tar
  -w Write to optical media
  -X Exclude file or directory from archive
  -r  Restore from optical media

 Disc technology flags are:

  -cd       for cd-rom
  -dvd      for single layer DVD+R
  -dvd-dl   for dual layer DVD+R
  -dvd-r    for single layer DVD-R
  -dvd-ram  for those who have it
  -bd       for single layer BluRay
  -bd-dl    for dual layer BluRay

 Preset tar parameters are -cvpML and -f

Example:

To Write:
   bak2dvd -w -d /dev/optical -dvd -C $HOME -a Documents -a "Library Files"
   bak2dvd -w -d 1,0,0 -cd -C $HOME -a Documents -a "Library Files"

To Restore:
   bak2dvd -r -d /dev/optical -dvd -C $HOME
EOF
}


options=0
declare -i tracklen
declare -i comp
declare -i rw
declare -a dir
declare -a filenames
dir=""
filenames=""
cdburner=""
altdvdburner=""
device=""
taropts=""

while test $# -gt 0; do
  case "$1" in
    \?) echo "Invalid option: -$1" >&2
        exit 1
        ;;
   -h|--help)  usage
        exit 0
        ;;
    -v)  echo "Version $currentVersion"
        exit 0
        ;;
    -u|update)
	getConfiguredClient || exit 1
        checkInternet || exit 1
        update
        exit 0
        ;;
    -d)
	shift
	if test $# -gt 0; then
		device=$1
	else
		echo "No optical device specified" >&2
		exit 1
	fi
	shift
	options=1
	;;
     -dvd)
		tracklen=4580000 # DVD+R capacity - 10M
		comp=0
		shift
		options=1
		;;
    -dvd-ram)
        # DVD-RAM for those who have this under appreciated, and under utilized media format
        tracklen=4463168 # DVD-RAM capacity - 10M
        comp=2
        shift
        getAltDVDburner # Media has same defect management as BD-RE. In fact you might call it the orginal.
        options=1
        ;;
     -dvd-dl)
		tracklen=8337408 # DVD+R DL capacity - 10M
		comp=2
		shift
		getAltDVDburner
		options=1
		;;
     -dvd-r)
		tracklen=4585536 #DVD-R single layer capacity -10M
		comp=4
		shift
		options=1
		;;
     -bd)
		tracklen=24166400 # This should be 10M less than total. Had miscalculated, now correct.
		comp=0
		shift
		getAltDVDburner # While growisofs canb be trusted, it'll be slow with *any* bd-re media because of defect management.
		options=1
		;;
     -bd-dl)
		tracklen=47294464 #same as above but dual layer
		comp=6
		shift
		getAltDVDburner
		options=1
		;;
     -cd)
		tracklen=712702 #700M cd-rom capacity - 4k, 10M is not an insigficant amount at this storage capacity!
		comp=8
		shift
		getCDburner
		options=1
		;;
    -a)
        shift
        if test $# -gt 0; then
            filenames=( "${filenames[@]}" "$1" )
        else
            echo "No filename or directory specified" >&2
            exit 1
        fi
        shift
        ;;
    -C)
            shift
            if test $# -gt 0; then
            dir=( "-C" )
            dir=( "${dir[@]}" "$1" )
        else
            echo "No directory specified." >&2
            exit 1
        fi
        shift
        ;;
     -t)
		shift
		if test $# -gt 0; then
			taropts=$1
		else
			echo "No options to tar specified." >&2
			exit 1
		fi
		shift
		options=1
		;;
     -r)
		rw=2
		shift
		;;
     -w)
		rw=1
		shift
		;;
    -X)
        shift
        if test $# -gt 0; then
            excludes=( "${excludes[@]}" "--exclude=" )
            excludes=( "${excludes[@]}""$1" )
        else
            echo "No excluded file or directory specified."
            exit 1
        fi
        shift
        ;;
    :)  echo "Option -$1 requires an argument." >&2
        exit 1
        ;;
    *)
        echo "Something bad happened or malformed arguments."
        exit 1
        ;;
  esac
done

# special set of first arguments that have a specific behavior across tools
if [[ $# == "0" && $options == "0" ]]; then
  usage ## if calling the tool with no flags and args chances are you want to return usage
  exit 0
elif [[ $# == "1" ]]; then
  if [[ $1 == "update" ]]; then
    getConfiguredClient || exit 1
    checkInternet || exit 1
    update || exit 1
    exit 0
  elif [[ $1 == "help" ]]; then
    usage
    exit 0
  fi
fi

## The rest of the conditions and code would go here
## Make sure to use checkInternet at least once before any time httpGet will be called.
## Make sure to call getConfiguredClient at least once before ever calling checkInternet.
trap "cleanup 2" 2
pipename="/tmp/$RANDOM.pipe"
fifoname="/tmp/$RANDOM.fifo"
#changed from mknod to mkfifo to  make script more cross platform
mkfifo $pipename
mkfifo $fifoname
tarpid=""
# Asign the fifo to a file descriptor. No need for ugly cat hack, and it actually works!
exec 7<>$fifoname
declare -i readlen
countlimit=""
# If no -d option was set then the script will be able to get this far, but will be stopped 
# otherwise confusing errors will happen. May change to give the user a chance to specify a device or quit at this point.
if [[ -z "$device" ]]
then
    echo "No device specified."
    exitcode=1
    cleanup $exitcode
fi

if [[ $rw -eq 1 ]]
then
	tarwrite $tracklen $pipename "$taropts"
elif [[ $rw -eq 2 ]]
then
	readlen=$tracklen+$comp
	tarread $pipename "$taropts"
fi

count=$(ps -A | grep "$tarpid" | wc -l)
# Check that tar is alive and prompt for media
if [[ $count -eq $countlimit ]]
then
	read -p "Insert media and press Enter:"
	if [[ $rw -eq 1 ]]
	then
		#call appropriate burning function here. Want to add support for mini CD's and mini DVD's at some point.
		if [[ $tracklen -le 712702 ]]
		then
			cdburn "$device" $pipename "$tarpid" "$count" "$countlimit" "$cdburner"
		else
			dvdburn "$device" $pipename "$tarpid" "$count" "$countlimit" "$altdvdburner"
		fi
	elif [[ $rw -eq 2 ]]
	then
		discread "$device" $pipename "$tarpid" "$count" "$countlimit" $readlen
    else
        echo "You need to specify option -w for writing a backup or -r for restoring from backup."
        exitcode=1
        cleanup $exitcode
	fi

else
	# otherwise something has gone wrong and we need to stop
	echo
	echo "Tar has died unexpectedly." >&2
	# Call cleanup function here
	exitcode=1
	cleanup $exitcode
fi
exitcode=0
cleanup $exitcode
# This exit is a sheet anchor. It probably isn't needed, but it makes me feel better.
exit 0
