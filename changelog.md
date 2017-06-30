<div align="center">

# Bash-Snippets Changelog

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
