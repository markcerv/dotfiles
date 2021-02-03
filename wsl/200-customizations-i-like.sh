#!/usr/bin/env bash
#
#
# This script will install the customizations that I like
#

DROPBOX_SSH_PATH=/mnt/c/Users/mark/Dropbox/sync/.ssh
LOCAL_SSH_PATH=~/.ssh

WINDOWS_HOME_PATH=/mnt/c/home
LOCAL_HOME_PATH=~/home

TIMEOUT_IN_SECONDS=15


indent()
{
	sed 's/^/   /'
}



customize_screen()
{
    FILE=~/.screenrc
    if [ -f "$FILE" ]; then
        echo "$FILE already exists. Ignoring."
    else
        cat <<EOF > $FILE
screen -t root sudo su -
screen -t bash2
screen -t bash3

select 0
startup_message off

caption always "%{= kw}%-w%{= bw}%n %t%{-}%+w %-= @%H - %c - (%l)"
#
# Call via:  screen -R -e^Hh -d
#
# to change the strings, look at:
# http://www.gnu.org/software/screen/manual/screen.html#String-Escapes
#
# to test your changes, you can either copy the above line, the do
# CTRL-H :  and then paste in the line above
#
# or, CTRL-H :source ~/.screenrc
EOF
        echo "Created $FILE"
        ls -al $FILE
    fi

}


create_dot_mrc_boot_script()
{

    FILE=~/.mrc_boot_script
    if [ -f "$FILE" ]; then
        echo "$FILE already exists. Ignoring."
    else
        cat <<EOF > $FILE
#If we made it in here, then that's a good thing

read -r -t 15 -p "Run the only on boot commands? [y/N] " response
response=${response,,}    # tolower

if [[ "$response" =~ ^(yes|y)$ ]]
then
    echo "All of these commands need sudo, so be prepared to enter in a password"
    sleep 2

    #Need to do this to get screens running cleanly
    echo "Screen cleanup"
    sudo /etc/init.d/screen-cleanup start

    #Let's also make sure postgres is running
    echo "Fire up postgresql"
    sudo service postgresql start

    #Let's also make sure ssh is running
    echo "Fire up ssh"
    sudo service ssh --full-restart

    #Let's also make sure redis is running (for celery)
    echo "Fire up redis-server"
    sudo service redis-server start
else
    echo "Doing nothing"
fi
EOF
        echo "Created $FILE"
        ls -al $FILE
    fi

}


copy_ssh_from_dropbox()
{
    # At top of file we define:
    # DROPBOX_SSH_PATH=/mnt/c/Users/mark/Dropbox/sync/.ssh/
    # LOCAL_SSH_PATH=~/.ssh/

    if [ -d "$LOCAL_SSH_PATH" ]; then
        echo "The path $LOCAL_SSH_PATH already exists. Ignoring."
    else
        if [ -d "$DROPBOX_SSH_PATH" ]; then
            echo "Excellent, $DROPBOX_SSH_PATH already exists."
            echo "Copying the files in there to $LOCAL_SSH_PATH"
            cp -a $DROPBOX_SSH_PATH $LOCAL_SSH_PATH
            chmod 700 $LOCAL_SSH_PATH
            chmod 700 $LOCAL_SSH_PATH/*
        else
            echo "Sorry, I can't find $DROPBOX_SSH_PATH"
        fi

    fi
}



create_symlink_to_home()
{
    # At top of file we define:
    # WINDOWS_HOME_PATH=/mnt/c/home
    # LOCAL_HOME_PATH=~/home

    if [ -d "$LOCAL_HOME_PATH" ]; then
        echo "The path $LOCAL_HOME_PATH already exists. Ignoring."
    else
        if [ -d "$WINDOWS_HOME_PATH" ]; then
            echo "Great - $WINDOWS_HOME_PATH already exists."
            echo "Linking the files in there to $LOCAL_HOME_PATH"
            ln -s $WINDOWS_HOME_PATH $LOCAL_HOME_PATH
        else
            echo "Sorry, I can't find $WINDOWS_HOME_PATH"
        fi

    fi
}


ask_to_run()
{
    function=$1
    phrase=$2

    echo "                              (you have $TIMEOUT_IN_SECONDS seconds to answer this question)"
    read -r -t $TIMEOUT_IN_SECONDS -p "Do you want to: $phrase? [y/N] " response
    echo " "

    if [[ "$response" =~ ^(yes|y)$ ]]
    then
	    $function | indent
    fi

    echo " "
    echo " "


}

main()
{
    ask_to_run customize_screen "Create the .screenrc file"

    ask_to_run create_dot_mrc_boot_script "Create the .mrc_boot_script"

    ask_to_run copy_ssh_from_dropbox "Copy over .ssh from dropbox"

    ask_to_run create_symlink_to_home "Symlink the 'home' directory"
}

main