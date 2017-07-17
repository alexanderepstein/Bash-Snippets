# SYNOPSIS

Simple wrapper for `qrify` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install qrify

# USAGE

Basic usage:

    $ sparrow plg run qrify -- <args>

For example:

    $ sparrow plg run qrify -- hello world

Run as sparrow task:

    $ sparrow project create utils

    $ sparrow task add utils qrify-text qrify

    $ sparrow task ini utils/qrify-text

      ---

      args:
        - Hello world

    $ sparrow task run utils/qrify-text

For qrify's arguments description follow [https://github.com/alexanderepstein/Bash-Snippets#qrify](https://github.com/alexanderepstein/Bash-Snippets#qrify)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



