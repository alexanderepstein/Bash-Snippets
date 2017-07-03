#!/bin/bash
#Author: Linyos Torovoltos https://github.com/linyostorovovoltos

echo -n "Installing Youtube Channel Viewer"
chmod a+x youtubeviewer
cp youtubeviewer /usr/local/bin/ > /dev/null 2>&1 || {echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }

echo "Success"

