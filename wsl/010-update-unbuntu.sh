#!/usr/bin/bash
#
#
# This script will check if you want to run and update/upgrade/autoremove
#

SECS=30
CMDS="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"

echo "This program will run the following commands: "
echo " "
echo " -- "
echo $CMDS
echo " -- "
echo " "

echo "                              (you have $SECS seconds to answer this question)"
read -r -t $SECS -p "Do you want to update your system w/ the above commands? [y/N] " response

if [[ "$response" =~ ^(yes|y)$ ]]
then
    echo "You might be propmted to enter your password (for sudo)"
    echo " "
    echo " "

    eval $CMDS
else
    echo " "
    echo "Either you didn't answer, or you said no..."
    echo "   ...doing nothing."
    echo " "
fi