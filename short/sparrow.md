# SYNOPSIS

Simple wrapper for `short` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install short

# USAGE

Basic usage:

    $ sparrow plg run short -- <args>

For example:

    $ sparrow plg run short -- tinyurl.com/jhkj

Run as sparrow task:

    $ sparrow project create utils

    $ sparrow task add utils short-unmusk-jhkj short

    $ sparrow task ini utils/short-unmusk-jhkj

      ---

      args:
        - tinyurl.com/jhkj

    $ sparrow task run utils/short-unmusk-jhkj

For short's arguments description follow [https://github.com/alexanderepstein/Bash-Snippets#short](https://github.com/alexanderepstein/Bash-Snippets#short)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



