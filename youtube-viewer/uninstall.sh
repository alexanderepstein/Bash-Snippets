#!/bin/bash
#Author: Linyos Torovoltos https://github.com/linyostorovovoltos

echo -n "Removing youtubeviewer: "
rm -f /usr/local/bin/youtubeviewer > /dev/null 2>&1 || { echo "Failed" ; echo "Error removing file, try running uninstall script as sudo"; exit 1; }

echo "Success"
