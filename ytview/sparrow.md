# SYNOPSIS

Simple wrapper for `ytview` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install ytview

# USAGE

Basic usage:

    $ sparrow plg run ytview -- <args>

For example:

    $ sparrow plg run ytview -- -s Family Guy Chicken Fight

Run as sparrow task:

    $ sparrow project create utils

    $ sparrow task add utils ytview-fg ytview

    $ sparrow task ini utils/ytview-fg

      ---

      args:
        - '-s'
        - Family Guy Chicken Fight

    $ sparrow task run utils/ytview-fg

For ytview's arguments description follow [https://github.com/alexanderepstein/Bash-Snippets#ytview](https://github.com/alexanderepstein/Bash-Snippets#ytview)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



