# SYNOPSIS

Simple wrapper for `movies` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install movies

# USAGE

Basic usage:

    $ sparrow plg run movies -- <params>

See parameters description at [https://github.com/alexanderepstein/Bash-Snippets#movies](https://github.com/alexanderepstein/Bash-Snippets#movies)

If you need some automation:

    $ sparrow project create utils

    $ sparrow task add utils $task-name movies

    $ sparrow task ini utils/$task-name

      ---

      params: <parameters here>

    $ sparrow task run utils/$task-name

# Author

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



