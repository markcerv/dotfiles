#
# Create an /etc/wsl.conf file
#

cat <<EOF > /tmp/wsl.conf
[automount]
enabled = true
options = "metadata,umask=22,fmask=11"

#
# More settings can be found at:
# https://docs.microsoft.com/en-us/windows/wsl/wsl-config#configure-per-distro-launch-settings-with-wslconf
#
EOF

sudo cp /tmp/wsl.conf /etc/wsl.conf