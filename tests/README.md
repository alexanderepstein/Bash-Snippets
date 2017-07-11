# SYNOPSIS

Simple wrapper for `tests` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install tests

# USAGE

Basic usage:

    $ sparrow plg run tests -- <params>

See parameters description at [https://github.com/alexanderepstein/Bash-Snippets#tests](https://github.com/alexanderepstein/Bash-Snippets#tests)

If you need some automation:

    $ sparrow project create utils

    $ sparrow task add utils $task-name tests

    $ sparrow task ini utils/$task-name

      ---

      params: <parameters here>

    $ sparrow task run utils/$task-name

# Author

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



