<div align="center">

# Bash-Snippets

<img src="http://icons.iconarchive.com/icons/paomedia/small-n-flat/1024/terminal-icon.png" height="250px" width="250px">

##### A collection of small bash scripts for heavy terminal users

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


## Encryption & Decryption

A wrapper for openssl that allows for quickly encrypting and decrypting files

<div align="center">

<img max-height="500px" max-width="500px" src="https://github.com/alexanderepstein/Bash-Snippets/blob/master/crypt/crypt.png?raw=true">

</div>

#### To Be Added
[ ] Pass in arguments as well on top of the option to have it guide you through input

## API's Used
* To get location based on ip address: <a href="ipinfo.io">ipinfo.io</a>
* To get and print weather based on a location: <a href="wttr.in">wttr.in</a>
* To grab the stock information in JSON format: <a href="https://www.alphavantage.co">alphavantage.co</a>
* To grab the latest exchange rate between currencies: <a href="http://api.fixer.io">api.fixer.io</a>

#### Inspired by: <a href="https://github.com/jakewmeyer/Ruby-Scripts">Ruby-Scripts</a>

## Installing

* First clone the repository:  ```git clone https://github.com/alexanderepstein/Bash-Snippets```

* Then cd into the cloned directory: ```cd Bash-Snippets```

#### To install all scripts
```bash
./install.sh
```

#### To install individual scripts
Ex. Weather
```bash
cd weather
./install.sh
```

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
