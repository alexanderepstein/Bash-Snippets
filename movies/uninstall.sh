#!/bin/bash
# Author: Alexander Epstein https://github.com/alexanderepstein
echo -n "Removing movies: "
rm -f /usr/local/bin/movies > /dev/null 2>&1 || { echo "Failed" ; echo "Error removing file, try running uninstall script as sudo"; exit 1; }
echo "Success"
