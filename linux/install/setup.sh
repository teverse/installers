#!/bin/bash

home="$(eval echo ~)"
teverseDir="${home}/teverse"
echo " _                               
| |_ _____   _____ _ __ ___  ___ 
| __/ _ \ \ / / _ \ '__/ __|/ _ \\
| ||  __/\ V /  __/ |  \__ \  __/
 \__\___| \_/ \___|_|  |___/\___| beta

"

read -p "Would you like to Teverse at ${teverseDir}? (y/n)  " response
if [ "$response" = "y" ]; then
    cp -r -v ./ $teverseDir
    rm $teverseDir/setup.sh

    echo "Setting up dependencies"
    ln -s $teverseDir/libopenal.so.1.20.1 $teverseDir/libopenal.so.1
    ln -s $teverseDir/libopenal.so.1.20.1 $teverseDir/libopenal.so

    if [ -f /etc/debian_version ]; then
        echo "Installing dependencies using apt-get"
        sudo apt-get install -y freeglut3
    else
        echo "Could not identify a suitable package manager, no dependencies could be installed."
    fi

    echo "Setting up Teverse"
    sudo mv $teverseDir/tevapp.xml /usr/share/mime/packages/tevapp.xml
    sudo update-mime-database /usr/share/mime
    sudo mv $teverseDir/teverse.desktop /usr/share/applications/teverse.desktop

    echo "Complete, thank you for installing Teverse for Linux."
else
    echo "Cancelled."
fi