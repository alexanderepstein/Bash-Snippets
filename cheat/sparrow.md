# SYNOPSIS

Simple wrapper for `cheat` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install cheat

# USAGE

Basic usage:

    $ sparrow plg run cheat -- <args>

For example:

    $ sparrow plg run cheat -- -i Perl

Run as sparrow task:

    $ sparrow project create utils

    $ sparrow task add utils cheat-perl cheat

    $ sparrow task ini utils/cheat-perl

      ---

      args:
        - '-i'
        - Perl
        - lwp-request

    $ sparrow task run utils/cheat-perl

For cheat's arguments description follow [https://github.com/alexanderepstein/Bash-Snippets#cheat](https://github.com/alexanderepstein/Bash-Snippets#cheat)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



