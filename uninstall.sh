#!/bin/bash
# Author: Alexander Epstein https://github.com/alexanderepstein
cd currency
./uninstall.sh || exit 1
cd ..
cd stocks
./uninstall.sh
cd ..
cd weather
./uninstall.sh
