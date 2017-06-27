#!/bin/bash
# Author: Alexander Epstein https://github.com/alexanderepstein
cd currency || exit 1
./install.sh || exit 1
cd .. || exit 1
cd stocks || exit 1
./install.sh
cd .. || exit 1
cd weather || exit 1
./install.sh
cd .. || exit 1
cd crypt || exit 1
./install.sh
cd .. || exit 1
cd movies || exit 1
./install.sh
