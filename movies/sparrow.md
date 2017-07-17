# SYNOPSIS

Simple wrapper for `movies` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install movies

# USAGE

Basic usage:

    $ sparrow plg run movies -- <args>

For example:

    $ sparrow plg run movies -- Argo

Run as sparrow task:

    $ sparrow project create utils

    $ sparrow task add utils movies-argo movies

    $ sparrow task ini utils/movies-argo

      ---

      args:
        - Argo

    $ sparrow task run utils/movies-argo

For movies's arguments description follow [https://github.com/alexanderepstein/Bash-Snippets#movies](https://github.com/alexanderepstein/Bash-Snippets#movies)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



