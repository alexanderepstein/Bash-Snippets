# SYNOPSIS

Simple wrapper for `stocks` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install stocks

# USAGE

Basic usage:

    $ sparrow plg run stocks -- <params>

See parameters description at [https://github.com/alexanderepstein/Bash-Snippets#stocks](https://github.com/alexanderepstein/Bash-Snippets#stocks)

If you need some automation:

    $ sparrow project create utils

    $ sparrow task add utils $task-name stocks

    $ sparrow task ini utils/$task-name

      ---

      params: <parameters here>

    $ sparrow task run utils/$task-name

# Author

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



