# SYNOPSIS

Simple wrapper for `geo` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install geo

# USAGE

Basic usage:

    $ sparrow plg run geo -- <args>

For example:

    $ sparrow plg run geo -- -r -d -m eth0

Run as sparrow task:

    $ sparrow project create utils

    $ sparrow task add utils geo-data geo

    $ sparrow task ini utils/geo-data

      ---

      args:
        - '-r'
        - '-d'
        - '~m' : eth0

    $ sparrow task run utils/geo-data

For geo's arguments description follow [https://github.com/alexanderepstein/Bash-Snippets#geo](https://github.com/alexanderepstein/Bash-Snippets#geo)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)
