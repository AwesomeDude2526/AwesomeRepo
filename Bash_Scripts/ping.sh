#!/bin/bash

### Check connectivity of servers, can use {1..10} to check multiple servers ###


for i in $@;   ### Can use $* as well ###

do ping -c 1 192.168.1.$i;

if [ $? = 0 ];
then echo "Host 192.168.1.$i is online" >> /root/hoststatus;
else echo "Host 192.168.1.$i is offline" >> /root/hoststatus;
fi

done
