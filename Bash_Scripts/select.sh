#!/bin/bash

echo -e "\nPlease make a selection:\n"

select menu in uptime servicestat free disk
do
case $menu in
uptime) uptime;;
servicestat) service sshd status;;
free) free -h;;
disk) df -h;;
*) break;;
esac
done

