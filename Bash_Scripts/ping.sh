#!/bin/bash

### Check connectivity of servers, can use {1..10} to check multiple servers ###


for i in $@;

do ping -c 1 192.168.1.$i;

if [ $? = 0 ];
then echo "Host 192.168.1.$i is online";
else echo "Host 192.168.1.$i is offline";
fi

done
