# SYNOPSIS

Simple wrapper for `cloudup` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install cloudup

# USAGE

Basic usage:

    $ sparrow plg run cloudup -- <params>

See parameters description at [https://github.com/alexanderepstein/Bash-Snippets#cloudup](https://github.com/alexanderepstein/Bash-Snippets#cloudup)

If you need some automation:

    $ sparrow project create utils

    $ sparrow task add utils $task-name cloudup

    $ sparrow task ini utils/$task-name

      ---

      params: <parameters here>

    $ sparrow task run utils/$task-name

# Author

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



