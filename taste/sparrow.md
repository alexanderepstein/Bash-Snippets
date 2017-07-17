# SYNOPSIS

Simple wrapper for `taste` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install taste

# USAGE

Basic usage:

    $ sparrow plg run taste -- <args>

For example:

    $ sparrow plg run taste -- -s Red Hot Chili Peppers

Run as sparrow task:

    $ sparrow project create utils

    $ sparrow task add utils taste-rhcp taste

    $ sparrow task ini utils/taste-rhcp

      ---

      args:
        - '-s'
        - Red Hot Chili Peppers

    $ sparrow task run utils/taste-rchp

For taste's arguments description follow [https://github.com/alexanderepstein/Bash-Snippets#taste](https://github.com/alexanderepstein/Bash-Snippets#taste)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



