# SYNOPSIS

Simple wrapper for `weather` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install weather

# USAGE

Basic usage:

    $ sparrow plg run weather -- <args>

For example:

    $ sparrow plg run weather -- Saint-Petersburg

Run as sparrow task:

    $ sparrow project create utils

    $ sparrow task add utils weather-spb weather

    $ sparrow task ini utils/weather-spb

      ---

      args:
        - Saint-Petersburg

    $ sparrow task run utils/weather-spb

For weather's arguments description follow [https://github.com/alexanderepstein/Bash-Snippets#weather](https://github.com/alexanderepstein/Bash-Snippets#weather)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



