# SYNOPSIS

Simple wrapper for `short` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install short

# USAGE

Basic usage:

    $ sparrow plg run short -- <args>

See parameters description at [https://github.com/alexanderepstein/Bash-Snippets#short](https://github.com/alexanderepstein/Bash-Snippets#short)

If you need some automation:

    $ sparrow project create utils

    $ sparrow task add utils $task-name short

    $ sparrow task ini utils/$task-name

      ---

      args:
        - foo
        - bar
        - so on ...

    $ sparrow task run utils/$task-name

# Author

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



