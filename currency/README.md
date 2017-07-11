# SYNOPSIS

Simple wrapper for `currency` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install currency

# USAGE

Basic usage:

    $ sparrow plg run currency -- <params>

See parameters description at [https://github.com/alexanderepstein/Bash-Snippets#currency](https://github.com/alexanderepstein/Bash-Snippets#currency)

If you need some automation:

    $ sparrow project create utils

    $ sparrow task add utils $task-name currency

    $ sparrow task ini utils/$task-name

      ---

      params: <parameters here>

    $ sparrow task run utils/$task-name

# Author

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



