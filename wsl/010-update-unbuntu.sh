#!/usr/bin/bash
#
# trying both !/usr/bin/env bash
# or maybe use /usr/bin/bash
#
# This script will check if you want to run and update/upgrade/autoremove
#

read -r -t 30 -p "Do you want to apt update/upgrade/autoremove? [y/N]" response

if [[ "$response" =~ ^(yes|y)$ ]]
then
    echo "You might be propmted to enter your password (for sudo)"
    echo " "
    echo " "

    sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
else
    echo "Either you didn't answer, or you said no..."
    echo "   ...doing nothing."
fi