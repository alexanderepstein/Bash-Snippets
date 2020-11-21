<div align="center">

# Bash-Snippets

<img src="https://cloud.githubusercontent.com/assets/2059754/24601246/753a7f36-1858-11e7-9d6b-7a0e64fb27f7.png" height="250px" width="250px">

##### A collection of small bash scripts for heavy terminal users with no dependencies

![Version](https://img.shields.io/github/release/alexanderepstein/Bash-Snippets.svg) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/a4bf023a3d0d499abc9d2bf14b296a14)](https://www.codacy.com/app/alexanderepstein/Bash-Snippets?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=alexanderepstein/Bash-Snippets&amp;utm_campaign=Badge_Grade) [![Build Status](https://travis-ci.org/alexanderepstein/Bash-Snippets.svg?branch=master)](https://travis-ci.org/alexanderepstein/Bash-Snippets) ![platform](https://img.shields.io/badge/platform-OSX%2C%20Linux%20%26%20Windows-blue.svg)  [![license](https://img.shields.io/github/license/mashape/apistatus.svg?style=plastic)]()



### All of these scripts have been heavily tested on macOS and Linux
### Most of these scripts have been tested on Windows 10 and the official developer bash instance. Does not work with Cygwin or Mysys2.

#### Looking for maintainers: I have been and probably will forever be too busy to maintain this properly on my own. I am looking for a few others to help out, if you want to be a maintainer either email me or raise an issue. I will probably only accept maintainers who have made a few contributions (no matter how small) and seem to understand the vision of this project.

</div>

## Tools

<details>
<summary>Cheat</summary>

The fastest way to find {command options|code pieces} you need

Supports multiple languages and many bash commands

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/cheat/cheat.png?raw=true">

</div>
</details>

<details>
<summary>Cloudup</summary>

A tool that facilitates backing up github repositories to bitbucket

If you have ever felt the fear of the github unicorn this could be your savior

Furthermore you can backup the repositories of any github user to your bitbucket.

Backup all github repositories of the designated user at once with the -a option.
Or run it with no flags and backup individual repositories.

<div align="center">

<img height="75%" width="75%" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/cloudup/cloudup.png?raw=true">

</div>
</details>


<details>
<summary>Crypt</summary>

A wrapper for openssl that allows for quickly encrypting and decrypting files

```bash
crypt -e [original file] [encrypted file] # encrypts files
crypt -d [encrypted file] [output file] # decrypts files
```
#### Encryption Details
* Uses AES 256 level encryption
* Key is salted before creation
* Password is never in plain text, and OpenSSL generates key based on password
* Encrypted data is encoded in Base64, so it can be used as plain text in an email. (Not usually necessary if attached as a file)

**Tested With**  .pdf, .txt, .docx, .doc, .png, .jpeg

**CAUTION**  Make sure to use different filenames, otherwise your file will be overwritten!


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/crypt/crypt.png?raw=true">

</div>
</details>


<details>
<summary>Cryptocurrency</summary>

Converts Cryptocurrency based on realtime exchange rates of the top 10 cryptos

<div align="center">

<img max-height="500px" max-width="505px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/cryptocurrency/cryptocurrency.png?raw=true">

</div>

Originally written by: [Jonas-Taha El Sesiy](https://github.com/elsesiy)
Heavy modifications by: [Alex Epstein](https://github.com/alexanderepstein)
</details>


<details>
<summary>Currency</summary>

Converts currency based on realtime exchange rates

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/currency/currency.png?raw=true">

</div>

If you want to bypass to guided input you can pass in 3 arguments and it will run from there
ex.```currency [baseCurrency] [exchangeToCurrency] [amountBeingExchanged]```
so a valid use case would be ```currency USD EUR 12.35```
</details>


<details>
<summary>Geo</summary>

Provides data for  wan, lan, router, dns, mac, and ip geolocation


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/geo/geo.png?raw=true">

</div>

Written by: [Jake Meyer](https://github.com/jakewmeyer)
</details>

<details>
<summary>Gist</summary>

Manage your gist like a pro

Clone your owned gists and starred gists as git repos, and Fetch/Create/Edit/Delete them with Github API. It also supports quick search with hashtag and contents.

For more information, please go through the [guide](gist/README.md)

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/gist/gist.png?raw=true">

</div>

Written by: [typebrook](https://github.com/typebrook)
</details>

<details>
<summary>Lyrics</summary>

Grab lyrics for a given song quickly from the command line.


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/lyrics/lyrics.png?raw=true">

</div>

</details>

<details>
<summary>Meme</summary>

A lightning fast meme generator.


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/meme/meme.png?raw=true">

</div>

</details>

<details>
<summary>Movies</summary>

Quick search that grabs relevant information about a movie

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/movies/movies.png?raw=true">

</div>
</details>


<details>
<summary>Newton</summary>

Performs numerical calculations all the way up to symbolic math parsing.

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/newton/newton.png?raw=true">

</div>
</details>


<details>
<summary>Qrify</summary>

Takes any string of text and turns it into a qr code

This is useful for sending links or saving a string of commands to your phone


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/qrify/qrify.png?raw=true">

</div>

Written by: [Linyos Torovoltos](http://github.com/linyostorovovoltos)
</details>


<details>
<summary>Short</summary>

Gets the link that is being masked by a url shortner

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/short/short.png?raw=true">

</div>
</details>

<details>
<summary>Siteciphers</summary>

Check which ciphers are enabled / disabled for a given https site.

Sometimes ciphers are deemed vulnerable, so when you are changing configuration, this can be used to confirm that the cipher truly is disabled.

Some browsers (For example old versions of IE) don't support some of the newer ciphers, which would be a good example of when a SysAdmin would need a list of currently supported ciphers so that changes can be made.

<div align="center">

<img height="75%" width="75%" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/siteciphers/siteciphers.png?raw=true">

</div>
</details>


<details>
<summary>Stocks</summary>

Provides information about a certain stock symbol


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/stocks/stocks.png?raw=true">

</div>
</details>


<details>
<summary>Taste</summary>

Recommendation engine that provides three similar items like the supplied item

Also can provide information on a given item

Valid items are: shows, books, music, artists, movies, authors, games

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/taste/taste.png?raw=true">

</div>

### Needs an API Key (don't worry it's free)
* Get the API key [here](https://tastedive.com/account/api_access)
* After getting the API key run the following line ```export TASTE_API_KEY="yourAPIKeyGoesHere" >> ~/.bash_profile```
</details>


<details>
<summary>Todo</summary>

A simplistic command line todo list


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/todo/todo.png?raw=true">

</div>
</details>


<details>
<summary>Transfer</summary>

Quickly transfer files from the command line.


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/transfer/transfer.png?raw=true">

</div>
</details>


<details>
<summary>Weather</summary>

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
</details>


<details>
<summary>Youtube-Viewer</summary>

Provides a way to watch youtube videos from the terminal.

You can use ```ytview -c [channel name]``` to see recent videos by that artist.

You can use ```ytview -s [videoToSearch]``` or just ```ytview [videoToSearch]``` to search for videos.


<div align="center">

<img height="75%" width="75%" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/ytview/ytview.png?raw=true">

</div>

Written by: [Linyos Torovoltos](http://github.com/linyostorovovoltos)
</details>

## API's Used

<details>
<summary>All API's</summary>

* To get location based on ip address: [ipinfo](https://ipinfo.io)
* To get and print weather based on a location: [wttr](http://wttr.in)
* To grab the stock information in JSON format: [alphavantage](https://www.alphavantage.co)
* To grab the latest exchange rate between currencies: [fixer](http://fixer.io)
* To grab information on movies: [omdbapi](http://www.omdbapi.com/)
* To grab recommendations based on an item: [tastedive](https://tastedive.com)
* To determine masked link behind url shortner: [ki.tc](http://ki.tc)
* To grab cheatsheets for commands and languages: [cheat](http://cheat.sh/)
* To encode text into a qr code: [qrenco](http://qrenco.de)
* To grab a list of a users repositories: [github](https://developer.github.com/v3/)
* To upload a repository to bitbucket: [bitbucket](https://developer.atlassian.com/bitbucket/api/2/reference/)
* To get your WAN ip address: [ipify](https://www.ipify.org/)
* To grab the latest exchange rate between cryptocurrencies to standard currencies: [coinmarketcap](https://coinmarketcap.com/api/)
* To perform symbolic math and other computations: [newton](https://newton.now.sh)
* To transfer files: [transfer](https://transfer.sh)
* To grab lyrics from a song: [lyrics.ovh](http://docs.lyricsovh.apiary.io)
* To generate memes: [MemeGen](https://memegen.link)
* To get a chart of the top 10 cryptocurrencies [rate.sx](http://rate.sx)

</details>


## Installing

[![Packaging status](https://repology.org/badge/vertical-allrepos/bash-snippets.svg)](https://repology.org/project/bash-snippets/versions)

<details>
  <summary>AUR</summary>
  
bash-snippets is available in two different AUR packages: `bash-snippets` and `bash-snippets-git`.

```bash
yay -S bash-snippets # or bash-snippets-git
```

</details>

<details>
  
<summary>APT Package Manager</summary>

```bash
sudo add-apt-repository ppa:navanchauhan/bash-snippets # add bash-snippets PPA
sudo apt update # update package list
sudo apt install bash-snippets # install bash-snippets package
```

</details>

<details>
  
  <summary>homebrew (macOS) / linuxbrew (Linux)</summary>

```bash
brew install bash-snippets # installs all tools
brew install bash-snippets --without-all-tools --with-newton --with-weather # specifying install for individual tools
```

</details>

<details>
  
  <summary>From Source</summary>

```bash
git clone https://github.com/alexanderepstein/Bash-Snippets # clone the repository
cd Bash-Snippets # cd into the cloned directory
git checkout v1.23.0 # Git checkout to the latest stable release
```
```bash
./install.sh all # install all scripts
```

or

```bash
./install.sh stocks # to install individual scripts
```
</details>

## Updating

<details>

<summary>AUR</summary>

```bash
yay -S bash-snippets # or bash-snippets-git
```
</details>


<details>
  
<summary>APT Package Manager</summary>

```bash
sudo apt update # update package list
sudo apt upgrade bash-snippets # upgrade bash-snippets package
```

</details>

<details>
  
<summary>homebrew (macOS) / linuxbrew (Linux)</summary>

```bash
brew install bash-snippets --without-all-tools --with-newton --with-weather # specifying install for individual tools
```

</details>

<details>
  
  <summary>From Source</summary>

With any of the installed tools you can automate the update by running it with the -u option or passing in update as the arguments Ex.

`stocks update`

or

`stocks -u`

This will clone the repository and install the new versions of scripts that were installed, if you didn’t install a certain tool this script will not install the new version of that tool.

</details>

## Uninstalling

<details>
  
  <summary>AUR</summary>

```bash
pacman -Rns bash-snippets # or bash-snippets-git
```

</details>

<details>
  
  <summary>APT Package Manager</summary>

```bash
sudo apt purge bash-snippets # you can also use remove instead of purge
```

</details>

<details>
  
  <summary>homebrew (macOS) / linuxbrew (Linux)</summary>

```bash
brew uninstall bash-snippets
```

</details>

<details>
  
  <summary>Git Uninstall</summary>
  
```bash
git clone https://github.com/alexanderepstein/Bash-Snippets # If you don't have the Bash-Snippets folder anymore clone the repository
cd Bash-Snippets # cd into the Bash-Snippets directory:
```

</details>

<details>
  
<summary>To go through a guided uninstall</summary>
```bash
./uninstall.sh
```

##### To uninstall all installed bash-snippets
```bash
./uninstall.sh all
```

##### To go through a guided uninstall
```bash
./uninstall.sh
```

##### To uninstall all installed bash-snippets
```bash
./uninstall.sh all
```

</details>


## Donate
If this project helped you in any way and you feel like supporting me

[![Donate](https://img.shields.io/badge/Donate-Venmo-blue.svg)](https://venmo.com/AlexanderEpstein)
[![Donate](https://img.shields.io/badge/Donate-SquareCash-green.svg)](https://cash.me/$AlexEpstein)

###### BTC: 38Q5VbH63MtouxHu8BuPNLzfY5B5RNVMDn
###### ETH: 0xf7c60C06D298FF954917eA45206426f79d40Ac9D
###### LTC: LWZ3T19YUk66dgkczN7dRhiXDMqSYrXUV4

#### Inspired by: [Ruby-Scripts](https://github.com/jakewmeyer/Ruby-Scripts)

## License

MIT License

Copyright (c) 2017 Alex Epstein

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
