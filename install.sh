#!/bin/bash
# root check
FILE="/tmp/out.$$"
GREP="/bin/grep"

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "Error : This script must be run as root" 1>&2
   exit 1
fi

read -p "This script will install startup.service into /etc/systemd/system and startup.sh into /usr/local/bin , is that okay ? y/n : " uConfirm
echo ""
if [ "$uConfirm" != "y" ]; then
    echo -e "Exit installer!\n"
    exit 0
fi

echo "Copy startup.service to /etc/systemd/system/startup.service ."
yes | cp -rf startup.service /etc/systemd/system/startup.service
echo "Copy startup.sh to /usr/local/bin/startup.sh ."
yes | cp -rf startup.sh /usr/local/bin/startup.sh

echo "Rum chmod ..."
chmod 664 /etc/systemd/system/startup.service
chmod 774 /usr/local/bin/startup.sh

echo "Enable service ..."
systemctl enable startup

echo "Done!"