# SYNOPSIS

Simple wrapper for `cryptocurrency` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install cryptocurrency

# USAGE

Basic usage:

    $ sparrow plg run cryptocurrency -- <args>

For example:

    $ sparrow plg run cryptocurrency -- ETH EUR 100

Run as sparrow task:

    $ sparrow project create utils

    $ sparrow task add utils cryptocurrency-eth-eur cryptocurrency

    $ sparrow task ini utils/cryptocurrency-eth-eur

      ---

      args:
        - ETH
        - EUR
        - 100

    $ sparrow task run utils/cryptocurrency-eth-eur

For cryptocurrency's arguments description follow [https://github.com/alexanderepstein/Bash-Snippets#cryptocurrency](https://github.com/alexanderepstein/Bash-Snippets#currency)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Jonas-Taha El Sesiy](https://github.com/elsesiy/)



