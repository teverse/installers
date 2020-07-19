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

        echo " 
     _                           _                 _           
  __| | ___ _ __   ___ _ __   __| | ___ _ __   ___(_) ___  ___ 
 / _\` |/ _ \ '_ \ / _ \ '_ \ / _\` |/ _ \ '_ \ / __| |/ _ \/ __|
| (_| |  __/ |_) |  __/ | | | (_| |  __/ | | | (__| |  __/\__ \\
 \__,_|\___| .__/ \___|_| |_|\__,_|\___|_| |_|\___|_|\___||___/
           |_|                       
"

    if [ -f /etc/debian_version ]; then
        echo "Installing using apt-get"
        sudo apt-get install -y freeglut3
    elif [ -f /etc/arch-release ]; then
        echo "Installing using pacman"
        sudo pacman -S --noconfirm freeglut
    elif [ -f /etc/redhat-release ]; then
        echo "Installing using yum"
        sudo yum install -y freeglut
    else
        echo "Could not identify a suitable package manager, no dependencies could be installed."
    fi

    echo "Setting up Teverse"
    
    mkdir ~/.icons
    cp $teverseDir/1024.png ~/.icons/teverse.png
    chmod +x $teverseDir/teverse.desktop
    sed -i "s~TEV_DIR~${teverseDir}~g" $teverseDir/teverse.desktop
    cp $teverseDir/teverse.desktop ~/.local/share/applications/teverse.desktop

    update-desktop-database
    xdg-mime default teverse.desktop x-scheme-handler/teverse

    echo " 
                           _      _       
  ___ ___  _ __ ___  _ __ | | ___| |_ ___ 
 / __/ _ \| '_ \` _ \| '_ \| |/ _ \ __/ _ \\
| (_| (_) | | | | | | |_) | |  __/ ||  __/
 \___\___/|_| |_| |_| .__/|_|\___|\__\___|
                    |_|                               
"
    echo "Complete, Teverse should now appear in your applications folder."
else
    echo "Cancelled."
fi