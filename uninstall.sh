#!/bin/bash
# Author: Alexander Epstein https://github.com/alexanderepstein
cd currency || exit 1
./uninstall.sh || exit 1
cd .. || exit 1
cd stocks || exit 1
./uninstall.sh
cd .. || exit 1
cd weather || exit 1
./uninstall.sh
cd .. || exit 1
cd crypt || exit 1
./uninstall.sh
cd .. || exit 1
cd movies || exit 1
./uninstall.sh
