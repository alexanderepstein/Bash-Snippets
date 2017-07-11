# SYNOPSIS

Simple wrapper for `weather` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install weather

# USAGE

Basic usage:

    $ sparrow plg run weather -- <params>

See parameters description at [https://github.com/alexanderepstein/Bash-Snippets#weather](https://github.com/alexanderepstein/Bash-Snippets#weather)

If you need some automation:

    $ sparrow project create utils

    $ sparrow task add utils $task-name weather

    $ sparrow task ini utils/$task-name

      ---

      params: <parameters here>

    $ sparrow task run utils/$task-name

# Author

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



