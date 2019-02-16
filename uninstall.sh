#!/bin/bash
# root check
FILE="/tmp/out.$$"
GREP="/bin/grep"

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "Error : This script must be run as root" 1>&2
   exit 1
fi

echo "Custom systemd startup script uninstaller"
read -p "Uninstall startup service, is that okay ? y/n : " uConfirm
if [ "$uConfirm" != "y" ]; then
    echo "Exit uninstaller!"
    exit 1
fi

echo "Stop startup.service..."
systemctl stop startup
echo "Disable startup.service..."
systemctl disable startup

echo "Remove /etc/systemd/system/startup.service ."
rm -f /etc/systemd/system/startup.service
echo "Remove /usr/local/bin/startup.sh ."
rm -f /usr/local/bin/startup.sh
echo "Remove /usr/local/bin/stop.sh ."
rm -f /usr/local/bin/stop.sh

echo "Done!"