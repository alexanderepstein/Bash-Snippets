# SYNOPSIS

Simple wrapper for `taste` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install taste

# USAGE

Basic usage:

    $ sparrow plg run taste -- <params>

See parameters description at [https://github.com/alexanderepstein/Bash-Snippets#taste](https://github.com/alexanderepstein/Bash-Snippets#taste)

If you need some automation:

    $ sparrow project create utils

    $ sparrow task add utils $task-name taste

    $ sparrow task ini utils/$task-name

      ---

      params: <parameters here>

    $ sparrow task run utils/$task-name

# Author

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



