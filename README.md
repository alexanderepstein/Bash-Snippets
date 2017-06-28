<div align="center">

# Bash-Snippets

<img src="http://icons.iconarchive.com/icons/paomedia/small-n-flat/1024/terminal-icon.png" height="250px" width="250px">

##### A collection of small bash scripts for heavy terminal users with no dependencies

![Version](https://img.shields.io/github/release/alexanderepstein/Bash-Snippets.svg) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/a4bf023a3d0d499abc9d2bf14b296a14)](https://www.codacy.com/app/alexanderepstein/Bash-Snippets?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=alexanderepstein/Bash-Snippets&amp;utm_campaign=Badge_Grade) ![platform](https://img.shields.io/badge/platform-OSX%20%26%20Linux-blue.svg)  [![license](https://img.shields.io/github/license/mashape/apistatus.svg?style=plastic)]()



### All of these scripts have only been tested on OSX and Linux and are not recommended for use with Windows

</div>

## Weather

Provides a 3 day forecast based on your ip address

<div align="center">

<img height="75%" width="75%" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/weather/weather.png?raw=true">

</div>

#### To Be Added
[ ] Take in location as arguments

## Stocks

Provides information about a certain stock symbol


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/stocks/stocks.png?raw=true">

</div>

## Currency

Converts currency based on realtime exchange rates

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/currency/currency.png?raw=true">

</div>

#### To Be Added
[ ] Pass in arguments as well on top of the option to have it guide you through input


## Encryption & Decryption

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

**Tested With** => .pdf, .txt, .docx, .doc, .png, .jpeg

**CAUTION** => Make sure to use different filenames, otherwise your file will be overwritten!


<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/crypt/crypt.png?raw=true">

</div>

## Movies

Quick search that grabs relevant information about a movie

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/movies/movies.png?raw=true">

</div>

## API's Used
* To get location based on ip address: <a href="ipinfo.io">ipinfo.io</a>
* To get and print weather based on a location: <a href="wttr.in">wttr.in</a>
* To grab the stock information in JSON format: <a href="https://www.alphavantage.co">alphavantage.co</a>
* To grab the latest exchange rate between currencies: <a href="http://api.fixer.io">api.fixer.io</a>
* To grab information on movies: <a href="http://www.omdbapi.com/">omdbapi.com</a>
#### Inspired by: <a href="https://github.com/jakewmeyer/Ruby-Scripts">Ruby-Scripts</a>

## Installing

* First clone the repository:  ```git clone https://github.com/alexanderepstein/Bash-Snippets```

* Then cd into the cloned directory: ```cd Bash-Snippets```

* Run the guided install script with
```bash
./install.sh
```
this will let you choose which scripts to install

## Uninstalling

* If you don't have the Bash-Snippets folder anymore clone the repository:  ```git clone https://github.com/alexanderepstein/Bash-Snippets```

* cd into the Bash-Snippets directory: ```cd Bash-Snippets```

#### To uninstall all scripts
```bash
./uninstall.sh
```

#### To uninstall individual scripts
Ex. Weather
```bash
cd weather
./uninstall.sh
```
## Donate
If this project helped you in any way and you feel like buying a broke college kid a cup of coffee

[![Donate](https://img.shields.io/badge/Donate-Venmo-blue.svg)](https://venmo.com/AlexanderEpstein)
[![Donate](https://img.shields.io/badge/Donate-SquareCash-green.svg)](https://cash.me/$AlexEpstein)

## License

MIT License

Copyright (c) 2017 Alex Epstein

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
