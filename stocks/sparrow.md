# SYNOPSIS

Simple wrapper for `stocks` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install stocks

# USAGE

Basic usage:

    $ sparrow plg run stocks -- <args>
    
For example:

    $ sparrow pl run stocks -- Google

Running via task:

    $ sparrow project create utils

    $ sparrow task add utils google-stocks stocks

    $ sparrow task ini utils/google-stocks

      ---

      args:
        - Google

    $ sparrow task run utils/google-stocks
    
See parameters description at [https://github.com/alexanderepstein/Bash-Snippets#stocks](https://github.com/alexanderepstein/Bash-Snippets#stocks)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



