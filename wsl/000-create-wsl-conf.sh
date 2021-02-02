#!/usr/bin/env bash
#
# Create an /etc/wsl.conf file
#

FILE=/etc/wsl.conf
TMP=/tmp/wsl.conf
if [ -f "$FILE" ]; then
    echo "Uh-oh, $FILE already exists. Aborting."
    exit 99
else 

    echo "Creating the $FILE file"
    cat <<EOF > $TMP
    [automount]
    enabled = true
    options = "metadata,umask=22,fmask=11"

    #
    # More settings can be found at:
    # https://docs.microsoft.com/en-us/windows/wsl/wsl-config#configure-per-distro-launch-settings-with-wslconf
    #
EOF

    sudo cp $TMP $FILE

    [ -f "$FILE" ] && echo "$FILE has been created:"
    [ -f "$FILE" ] && ls -al $FILE
    [ -f "$FILE" ] && echo " "

    # cleaning up
    rm $TMP
    exit 0
fi