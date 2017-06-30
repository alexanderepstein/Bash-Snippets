#!/bin/bash

echo -n "Installing movies: "
if brew help 1>/dev/null 2>/dev/null; then
        brew install googler
fi
chmod a+x movies
cp movies /usr/local/bin > /dev/null 2>&1 || { echo "Failure"; echo "Error copying file, try running install script as sudo"; exit 1; }
echo "Success"
