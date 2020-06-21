#!/bin/bash

echo "Name of this script is $0, it will check for installed packages"
for i in `cat hosts`;
do
sshpass -f /root/pass.txt ssh $i "hostname ; hostname -I ; uptime ; if yum list installed telnet; then echo "package exists"; else echo "package not installed"; fi";
done



read -s PASS
echo "Name of this script is $0, it will check for installed packages"
for i in `cat hosts`;
do
sshpass -p $PASS ssh $i "hostname ; hostname -I ; uptime ; if yum list installed telnet; then echo "package exists"; else echo "package not installed"; fi";
done
