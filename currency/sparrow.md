# SYNOPSIS

Simple wrapper for `currency` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install currency

# USAGE

Basic usage:

    $ sparrow plg run currency -- <args>

For example:

    $ sparrow plg run currency -- USD RUB 100

Run as sparrow task:

    $ sparrow project create utils

    $ sparrow task add utils currency-usd-rub currency

    $ sparrow task ini utils/currency-usd-rub

      ---

      args:
        - USD
        - RUB
        - 100

    $ sparrow task run utils/currency-usd-rub

For currency's arguments description follow [https://github.com/alexanderepstein/Bash-Snippets#currency](https://github.com/alexanderepstein/Bash-Snippets#currency)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



