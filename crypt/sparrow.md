# SYNOPSIS

Simple wrapper for `crypt` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install crypt

# USAGE

Basic usage:

    $ sparrow plg run crypt -- <args>

Run as sparrow task:

    $ sparrow project create utils

    $ sparrow task add utils enc-file crypt

    $ sparrow task ini utils/enc-file

      ---

      args:
        - '-e'
        - /tmp/file.txt
        - /tmp/file.txt.inc

    $ sparrow task run utils/enc-file

For crypt's arguments description follow [https://github.com/alexanderepstein/Bash-Snippets#cheat](https://github.com/alexanderepstein/Bash-Snippets#crypt)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



