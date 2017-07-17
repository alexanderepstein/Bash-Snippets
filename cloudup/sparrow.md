# SYNOPSIS

Simple wrapper for `cloudup` script from Bash-Snippets.


# INSTALL

    $ sparrow plg install cloudup

# USAGE

Basic usage:

    $ sparrow plg run cloudup -- <args>
    
For example:

    $ sparrow plg run cloudup -- -p repo1 repo2 repo3

If you need some automation:

    $ sparrow project create utils

    $ sparrow task add utils backup-top-repos cloudup

    $ sparrow task ini utils/backup-top-repos

      ---

      args:
        - '-p'
        - repo1
        - repo2
        - repo3

    $ sparrow task run utils/backup-top-repos

See parameters description at [https://github.com/alexanderepstein/Bash-Snippets#cloudup](https://github.com/alexanderepstein/Bash-Snippets#cloudup)

# Authors

* The author of main script is [Alex Epstein](https://github.com/alexanderepstein)

* The plugin maintainer is [Alexey Melezhik](https://github.com/melezhik/)



