#!/bin/bash
# Author: Alexander Epstein https://github.com/alexanderepstein
cd currency
./install.sh || exit 1
cd ..
cd stocks
./install.sh
cd ..
cd weather
./install.sh
