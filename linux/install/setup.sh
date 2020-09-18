#!/bin/bash

home="$(eval echo ~)"
deviapDir="${home}/deviap"
echo "
  ____  _______     _____    _    ____  
 |  _ \| ____\ \   / /_ _|  / \  |  _ \ 
 | | | |  _|  \ \ / / | |  / _ \ | |_) |
 | |_| | |___  \ V /  | | / ___ \|  __/ 
 |____/|_____|  \_/  |___/_/   \_\_| a l p h a                                    
"

read -p "Would you like to Deviap at ${deviapDir}? (y/n)  " response
if [ "$response" = "y" ]; then
    cp -r -v ./ $deviapDir
    rm $deviapDir/setup.sh

    echo "Setting up dependencies"
    ln -s $deviapDir/libopenal.so.1.20.1 $deviapDir/libopenal.so.1
    ln -s $deviapDir/libopenal.so.1.20.1 $deviapDir/libopenal.so

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

    echo "Setting up Deviap"
    
    mkdir ~/.icons
    cp $deviapDir/1024.png ~/.icons/deviap.png
    chmod +x $deviapDir/deviap.desktop
    sed -i "s~TEV_DIR~${deviapDir}~g" $deviapDir/deviap.desktop
    cp $deviapDir/deviap.desktop ~/.local/share/applications/deviap.desktop

    update-desktop-database
    xdg-mime default deviap.desktop x-scheme-handler/deviap

    echo " 
                           _      _       
  ___ ___  _ __ ___  _ __ | | ___| |_ ___ 
 / __/ _ \| '_ \` _ \| '_ \| |/ _ \ __/ _ \\
| (_| (_) | | | | | | |_) | |  __/ ||  __/
 \___\___/|_| |_| |_| .__/|_|\___|\__\___|
                    |_|                               
"
    echo "Complete, Deviap should now appear in your applications folder."
else
    echo "Cancelled."
fi