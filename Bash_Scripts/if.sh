#!/bin/bash

if [ 10 -gt 2 ]; then echo "its greater"; else echo "its less"; fi
if [ 10 != 2 ]; then echo "not equal"; else echo "its equal"; fi
if [ -e /root/file ]; then echo "file exists"; else touch /root/file; fi


echo "Enter username"
read username
echo "Enter password"
read password

if [[ $username = admin && $password = secret ]];
then echo "valid user";
else echo "invalid user";
fi
