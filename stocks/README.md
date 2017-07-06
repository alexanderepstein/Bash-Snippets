# SYNOPSIS

Provides information about a certain stock symbol

# INSTALL

    $ sparrow plg install stocks

# USAGE

Basic usage:

    $ sparrow plg run stocks --param name=Google


Or if you need some automation:


    $ sparrow project create utils

    $ sparrow task add utils stocks-google stocks

    $ sparrow task ini utils/stocks-google

    ---
    name: Google


    $ sparrow task run utils/stocks-google

# Output 

![stocks output](https://raw.githubusercontent.com/alexanderepstein/Bash-Snippets/master/stocks/stocks.png)


# Author

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)
* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



