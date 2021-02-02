#!/usr/bin/bash
#
#
# This script will make certain changes to the /etc/ssh/sshd_config file
#

SECS=30
FILE="/etc/ssh/sshd_config"
CMDS="sudo service ssh --full-restart"

echo "This script will make certain changes to $FILE"
echo "It will use **sudo** so don't be surprised if you get asked for your password."
echo " "

echo " ---- PasswordAuthentication section ----"
found=`grep 'PasswordAuthentication no' $FILE`
if [ "$found" ]; then
    echo "Updating 'PasswordAuthentication' from 'no' to 'yes'"
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' $FILE
else
    echo "PasswordAuthentication might already be set to yes"
fi

echo " ---- ListenAddress section ----"
found=`grep '#ListenAddress 0.0.0.0' $FILE`
if [ "$found" ]; then
    echo "Uncommenting 'ListenAddress 0.0.0.0' line"
    sudo sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/' $FILE
else
    echo "ListenAddress might already be uncommented"
fi

echo " ---- Port section ----"
found=`egrep '^#Port 22$' $FILE`
if [ "$found" ]; then
    echo "Uncommenting and Updating Port from 22 to 2220"
    sudo sed -i 's/^#Port 22$/Port 2220/' $FILE
else
    found=`egrep '^Port 22$' $FILE`
    if [ "$found" ]; then
        echo "Updating Port from 22 to 2220"
        sudo sed -i 's/^Port 22$/Port 2220/' $FILE
    else
        echo "This is what the port is set to in $FILE:"
        egrep '^Port' $FILE
    fi
fi

CHECK_FOR="/etc/ssh/ssh*key*"
if ls $CHECK_FOR 1> /dev/null 2>&1; then
    echo "$CHECK_FOR files DO exist"
else
    echo " "
    echo "********** WARNING **********"
    echo "$CHECK_FOR files DO NOT exist"
    echo "********** WARNING **********"
    echo " " 
    echo "You must run this first:"
    echo "    sudo ssh-keygen -A"
    echo " "
    echo "                              (you have $SECS seconds to answer this question)"
    read -r -t $SECS -p "Do you want to generate ssh keys w/ the above command? [y/N] " response

    if [[ "$response" =~ ^(yes|y)$ ]]
    then
        echo "You might be prompted to enter your password (for sudo)"
        echo " "
        echo " "

        sudo /usr/bin/ssh-keygen -A
        sudo /usr/bin/ssh-keygen -A
    else
        echo " "
        echo "Either you didn't answer, or you said no..."
        echo "   ...doing nothing."
        echo " "
    fi

fi


echo " "
echo " -- "
echo $CMDS
echo " -- "
echo "                              (you have $SECS seconds to answer this question)"
read -r -t $SECS -p "Do you want to resart ssh w/ the above commands? [y/N] " response

if [[ "$response" =~ ^(yes|y)$ ]]
then
    echo "You might be prompted to enter your password (for sudo)"
    echo " "
    echo " "

    eval $CMDS
else
    echo " "
    echo "Either you didn't answer, or you said no..."
    echo "   ...doing nothing."
    echo " "
fi
