#!/bin/sh
# Author: Alexander Epstein https://github.com/alexanderepstein
country=$(curl -s ipinfo.io/country) > /dev/null
if [ $country = "US" ];then
  city=$(curl -s ipinfo.io/city) > /dev/null
  region=$(curl -s ipinfo.io/region) > /dev/null
  region=$(echo "$region" | tr -dc '[:upper:]')
  curl wttr.in/$city,$region
else
  location=$(curl -s ipinfo.io/loc) > /dev/null
  curl wttr.in/$location
fi
