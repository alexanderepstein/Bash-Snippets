<div align="center">

# Bash-Snippets

<img src="https://cloud.githubusercontent.com/assets/2059754/24601246/753a7f36-1858-11e7-9d6b-7a0e64fb27f7.png" height="250px" width="250px">

##### A collection of small bash scripts for heavy terminal users with no dependencies

![Version](https://img.shields.io/github/release/alexanderepstein/Bash-Snippets.svg) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/a4bf023a3d0d499abc9d2bf14b296a14)](https://www.codacy.com/app/alexanderepstein/Bash-Snippets?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=alexanderepstein/Bash-Snippets&amp;utm_campaign=Badge_Grade) ![platform](https://img.shields.io/badge/platform-OSX%2C%20Linux%20%26%20Windows-blue.svg)  [![license](https://img.shields.io/github/license/mashape/apistatus.svg?style=plastic)]()



### All of these scripts have been heavily tested on OSX and Linux
### Most of these scripts have been tested on Windows 10 and the official developer bash instance. Does not work with Cygwin or Mysys2.

</div>



## Weather

Provides a 3 day forecast

With no arguments it will grab the weather for your location as determined by your ip

<div align="center">

<img height="75%" width="75%" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/weather/weather.png?raw=true">

</div>

With arguments you can pass in a city or country and get the weather in that area


Also can show the current moon phase

<div align="center">

<img height="75%" width="75%" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/weather/moon.png?raw=true">

</div>


## Youtube-Viewer

Provides a way to watch youtube videos from the terminal.

You can use ```ytview -c [channel name]``` to see recent videos by that artist.

You can use ```ytview -s [videoToSearch]``` or just ```ytview [videoToSearch]``` to search for videos.


<div align="center">

<img height="75%" width="75%" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/ytview/ytview.png?raw=true">

</div>

Written by: <a href="http://github.com/linyostorovovoltos">Linyos Torovoltos</a>

## Stocks

Provides information about a certain stock symbol


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/stocks/stocks.png?raw=true">

</div>


## Geo
  Provides date for  wan, lan, router, dns, mac, and ip geolocation


  <div align="center">

  <img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/geo/geo.png?raw=true">

  </div>

  Written by: <a href="https://github.com/jakewmeyer">Jake Meyer</a>

## Currency

Converts currency based on realtime exchange rates

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/currency/currency.png?raw=true">

</div>

If you want to bypass to guided input you can pass in 3 arguments and it will run from there
ex.```currency [baseCurrency] [exchangeToCurrency] [amountBeingExchanged]```
so a valid use case would be ```currency USD EUR 12.35```

## Cloudup

A tool that facilitates backing up github repositories to bitbucket

If you have ever felt the fear of the github unicorn this could be your savior

Furthermore you can backup the repositories of any github user to your bitbucket.


<div align="center">

<img height="75%" width="75%" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/cloudup/cloudup.png?raw=true">

</div>



## Crypt

A wrapper for openssl that allows for quickly encrypting and decrypting files

```bash
crypt -e [original file] [encrypted file] # encrypts files
crypt -d [encrypted file] [output file] # decrypts files
```
#### Encryption Details
* Uses AES 256 level encryption
* Key is salted before creation
* Password is never in plain text, and OpenSSL generates key based on password
* Data is encrypted in Base64, so it can be used as plain text in an email. (Not usually necessary if attached as a file)

**Tested With**  .pdf, .txt, .docx, .doc, .png, .jpeg

**CAUTION**  Make sure to use different filenames, otherwise your file will be overwritten!


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/crypt/crypt.png?raw=true">

</div>

## Movies

Quick search that grabs relevant information about a movie

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/movies/movies.png?raw=true">

</div>


## Cheat


The fastest way to find {command options|code pieces} you need

Supports multiple languages and many bash commands

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/cheat/cheat.png?raw=true">

</div>


## Taste

Recommendation engine that provides three similar items like the supplied item

Also can provide information on a given item

Valid items are: shows, books, music, artists, movies, authors, games

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/taste/taste.png?raw=true">

</div>

### Needs an API Key (don't worry it's free)
* Get the API key here: <a href="https://tastedive.com/account/api_access">taste dive</a>
* After getting the API key add the following line to your ~/.bash_profile: ```export TASTE_API_KEY="yourAPIKeyGoesHere"```

## Qrify

Takes any string of text and turns it into a qr code

This is useful for sending links or saving a string of commands to your phone


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/qrify/qrify.png?raw=true">

</div>

Written by: <a href="http://github.com/linyostorovovoltos">Linyos Torovoltos</a>

## Short

Gets the link that is being masked by a url shortner

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/short/short.png?raw=true">

</div>

## API's Used
* To get location based on ip address: <a href="https://ipinfo.io">ipinfo.io</a>
* To get and print weather based on a location: <a href="http://wttr.in">wttr.in</a>
* To grab the stock information in JSON format: <a href="https://www.alphavantage.co">alphavantage.co</a>
* To grab the latest exchange rate between currencies: <a href="http://fixer.io">fixer.io</a>
* To grab information on movies: <a href="http://www.omdbapi.com/">omdbapi.com</a>
* To grab recommendations based on an item: <a href="https://tastedive.com">tastedive.com</a>
* To determine masked link behind url shortner: <a href="http://x.datasig.io">x.datasig.io</a>
* To grab cheatsheets for commands and languages: <a href="http://cheat.sh/">cheat.sh</a>
* To encode text into a qr code: <a href="http://qrenco.de">qrenco.de</a>

#### Inspired by: <a href="https://github.com/jakewmeyer/Ruby-Scripts">Ruby-Scripts</a>

## Installing

### For Mac via homebrew
```bash
brew install chainsawbaby/formula/bash-snippets
```

### Otherwise

* First clone the repository:  ```git clone https://github.com/alexanderepstein/Bash-Snippets```

* Then cd into the cloned directory: ```cd Bash-Snippets```

* Git checkout to the latest stable release ```git checkout v1.11.0```

* Run the guided install script with
```bash
./install.sh
```
this will let you choose which scripts to install

* Install all the scripts
```bash
./install.sh all
```

* Install an individual script
```bash
./install.sh stocks
```

## Updating

### For Mac if installed via homebrew
```bash
brew update bash-snippets
```

### Otherwise

With any of the installed tools you can automate the update by running it with the -u option or passing in update as the arguments
Ex.
```bash
stocks update
```
or
```bash
stocks -u
```
This will clone the repository and install the new versions of scripts that were installed, if you didn't install a certain tool this script will not install the new version of that tool.

## Uninstalling

### For Mac if installed via homebrew
```bash
brew uninstall bash-snippets
```

### Otherwise
* If you don't have the Bash-Snippets folder anymore clone the repository:  ```git clone https://github.com/alexanderepstein/Bash-Snippets```

* cd into the Bash-Snippets directory: ```cd Bash-Snippets```

#### To go through a guided uninstall
```bash
./uninstall.sh
```

## Donate
If this project helped you in any way and you feel like buying a broke college kid a cup of coffee

[![Donate](https://img.shields.io/badge/Donate-Venmo-blue.svg)](https://venmo.com/AlexanderEpstein)
[![Donate](https://img.shields.io/badge/Donate-SquareCash-green.svg)](https://cash.me/$AlexEpstein)

<div align="center">

## Poll



#### Favorite Tool?

[![](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Weather)](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Weather/vote)
[![](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Yotube-Viewer)](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Yotube-Viewer/vote)
[![](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Stocks)](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Stocks/vote)
[![](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Geo)](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Geo/vote)
[![](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Currency)](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Currency/vote)
[![](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Cloudup)](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Cloudup/vote)
[![](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Crypt)](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Crypt/vote)
[![](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Movies)](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Movies/vote)
[![](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Cheat)](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Cheat/vote)
[![](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Taste)](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Taste/vote)
[![](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Short)](https://m131jyck4m.execute-api.us-west-2.amazonaws.com/prod/poll/01BM73YVF896YZJ5GQE77VDCMJ/Short/vote)

</div>

## License

MIT License

Copyright (c) 2017 Alex Epstein

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
