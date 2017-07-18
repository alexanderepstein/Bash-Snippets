<div align="center">

# Bash-Snippets Changelog

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
