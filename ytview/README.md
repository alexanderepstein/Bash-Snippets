# SYNOPSIS

Simple wrapper for `ytview` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install ytview

# USAGE

Basic usage:

    $ sparrow plg run ytview -- <params>

See parameters description at [https://github.com/alexanderepstein/Bash-Snippets#ytview](https://github.com/alexanderepstein/Bash-Snippets#ytview)

If you need some automation:

    $ sparrow project create utils

    $ sparrow task add utils $task-name ytview

    $ sparrow task ini utils/$task-name

      ---

      params: <parameters here>

    $ sparrow task run utils/$task-name

# Author

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



