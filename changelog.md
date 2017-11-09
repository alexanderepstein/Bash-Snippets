<div align="center">

# Bash-Snippets Changelog

## Version 1.20.0

## Changes
* Brought back lyrics tool
* Added shorten url functionality to short
* Fixed the stocks api
* Save QRCodes to an image file
* Fixed bug in qrify for single-word strings
* Adding mdfind functionality to ytview

</div>

<div align="center">

## Version 1.19.2

## Changes
* ytview for macOS can now use mpv
* lyrics tool was removed, api is not available anymore

</div>

<div align="center">

## Version 1.19.1

</div>

## Changes
* Fixed bug in todo for task lists over 8 tasks
* Fixing the endpoint in the short tool

<div align="center">

## Version 1.19.0

</div>

### Changes
* Adding BCH to cryptocurrencies tool
* Adding lyrics component

<div align="center">

## Version 1.18.1

</div>

### Changes
* Changed how transfer uploads files
* Upload multiple files with transfer
* Get tasks after removal of tasks in todo
* Bulk removal of tasks in todo
* Removing bad echo from cloudup

<div align="center">

## Version 1.18.0

</div>

### Changes
* Added transfer component
* Fixing fetch call across all tools
* Changing progress echos for update
* Run checkInternet only when needed (speeds up processes that don't need it)
* Hiding the api help page in weather

<div align="center">

## Version 1.17.3

</div>

### Changes
* checkInternet now checks github.com over google.com
* tools that don't need bc don't use it
* tools that need bc can approximate without it
* Fixing trailing quotation mark for newton on osx
* Adding all option to uninstall


<div align="center">

## Version 1.17.2

</div>

### Changes
* Fixing where manpage is installed for linuxbrew
* Updating weather usage and manpage

<div align="center">

## Version 1.17.1

</div>

### Bugfixes
* Fixing grabbing the prefix in homebrew install

<div align="center">

## Version 1.17.0

</div>

### Changes
* Adding ability to use m/s for windspeed in weather
* Supporting httpie for all tools that work with it
* Install for homebrew can now handle multiple tools on one line

<div align="center">

## Version 1.16.2

</div>

### Changes
* Adding back all argument to homebrew install

<div align="center">

## Version 1.16.1

</div>

### Changes
* Changed install script for homebrew
* Added the -r option to newton

<div align="center">

## Version 1.16.0

</div>

### Changes
* Added cryptocurrency component
* Added newton component
* Changed WAN Call in geo

<div align="center">

## Version 1.15.2

</div>

### Bugfixes
* Installer path was preventing install

<div align="center">

## Version 1.15.1

</div>


### Changes
* Added --prefix option to installer for homebrew correctly

<div align="center">

## Version 1.15.0

</div>

### Changes
* Added -d option to movies
* Updating extra tools if installed in main update pipeline

<div align="center">

## Version 1.14.3

</div>

### Changes
* Adding new progress echos to cloudup

### Bugfixes
* Fixed bug in all tools using python for OSX where it would result caught in a segfault

<div align="center">

## Version 1.14.2

</div>

### Bugfixes
* Fixing bug where cloudup was incorrectly deleting the remote bitbucket repository.

<div align="center">

## Version 1.14.1

</div>

### Bugfixes
* Fixing issue in cloudup remote url was not set correctly if the ```-t``` option was not used
* Fixing issue in cloudup where tags were causing conflicts, solved by deleting bitbucket repo first

<div align="center">

## Version 1.14.0

</div>

### Changes
* Shebang changed to ```/usr/bin/env bash``` for more portability
* Todo has more error checking for bad input
* Added the ```-s``` option to cloudup which will prevent the backup of forked repositories
* Added the ```-t``` option to cloudup to give the user the ability to create a unique repo or just update the old one

<div align="center">

## Version 1.13.2

</div>


### Changes
* Updated installer not allow updates if bash-snippets was installed through package manager

<div align="center">

## Version 1.13.1

</div>

### Changes
* Preventing bad input in ```todo -r```
* Stocks was using unnecessary characters in the URL
* Cloudup's private option now works
* Cloudup's all option now looks to backup the first 10,000 repositories versus 100

<div align="center">

## Version 1.13.0

</div>

### Changes
* Added todo component

### Bugfixes
* Forcing ytview to search in english

<div align="center">

## Version 1.12.0

</div>

### Changes
* Added siteciphers component

### Bugfixes
* Crypt was still using only curl to get tags for update

<div align="center">

## Version 1.11.1

</div>

### Changes
* Now supporting the use of proxies
* Typo fixes
* Adding IMDB rating to movies tool

### Bugfixes
* Suppressing ```source ~/.bash_profile``` error


<div align="center">

## Version 1.11.1

</div>

### Bugfixes
* Fixed issue in ytview where it was playing wrong video
* Fixed wget check in qrify

<div align="center">

## Version 1.11.0

</div>

### Changes
* Adding manpage, view it with ```man bash-snippets```

<div align="center">

## Version 1.10.1

</div>


### Changes
* Cloudup's -a option is now functional

### Bugfixes
* Cloudup only needs one temporary copy of the repository
* Qrify had an issue where it couldn't handle more than one space
* Cloudup now retains git history when it backs up to bitbucket
* Fetch removed from qrify since it will not work


<div align="center">

## Version 1.10.0

</div>

### Changes
* Added qrify component

### Bugfixes
* Bug in taste where the -i option was not working
* Bug in all scripts that used python on OSX
* Bug in taste script on OSX

<div align="center">

## Version 1.9.0

</div>

### Changes
* Added cloudup component

### Bugfixes
* Fixing bug in ytview when search results are sparse


<div align="center">

## Version 1.8.0

</div>

### Changes
* Added ytview component

### Bugfixes
* Using ```$@``` instead of ```$1 $2 $3...``` in all applicable scripts
* Make call to python 2 explicit in all applicable scripts
* Hiding the cheatsheet api help page from the user


<div align="center">

## Version 1.7.0

</div>

### Changes
* Added cheat component

<div align="center">

## Version 1.6.0

</div>

### Changes
* Added geo component

<div align="center">

## Version 1.5.0

</div>

### Changes
* Added short component
### Bugfixes
* Sending errors in taste tool to /den/null
* Taste tool only has one unique youtube link not three

<div align="center">

## Version 1.4.0

</div>

# Changes
* Added taste component

<div align="center">

## Version 1.3.1

</div>

### Bugfixes
* Fixing bug in currency where invalid exchangeTo wasn't handled correctly


<div align="center">

## Version 1.3.0

</div>

### Changes
* Now supporting wget, fetch and curl
* Cleaning an echo on error for updating

<div align="center">

## Version 1.2.1

</div>

### Changes
* Check if curl is installed before using it
* No sudo on error in update, just let user know they need to run the command as sudo
* Changelog added
### Bugfixes
* Setting user agent for curl to prevent issues from changes in  ~/.curlrc

<div align="center">

## Version 1.2.0

</div>

### Changes
* Added help to each tool call with ```-h```
* Can now call weather with metric or imperial units
* Can now get the moon phase from weather
* Adding locale to weather so it will return in native language

<div align="center">

## Version 1.1.1

</div>

### Changes
* Now you can pass arguments to the weather tool to get weather of a location other then your own
* Now you can pass arguments to the currency tool to bypass the guided input
* The output for the currency tool is cleaner
### Bugfixes
* Fixed bug in currency where exchange rate was not parsed correctly
* Fixed bug in stocks where you could get lost in the tool by providing no input


<div align="center">

## Version 1.1.0

</div>

### Changes
* Facilitate updating by calling any of the tools with the -u option or update as the argument ex ```weather -u``` or ```weather update```

<div align="center">

## Version 1.0.0


</div>

### Initial Release
* Weather component added
* Stocks component added
* Movies component added
* Currency component added
* Crypt component added
