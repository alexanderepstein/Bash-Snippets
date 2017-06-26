#!/bin/sh
# Author: Alexander Epstein https://github.com/alexanderepstein
getWeather()
{
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
}

checkInternet()
{
  echo "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1

  if [ $? -eq 0 ]; then
    return 0
  else
    echo "Error: no active internet connection" >&2
    return 1
  fi
}

checkInternet || exit 1
getWeather
