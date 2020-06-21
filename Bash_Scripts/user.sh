#!/bin/bash

echo "Enter server name: "
read server
echo "Enter username: "
read username
echo "Enter password: "
read password

if [[ $username = "linux" && $password = "secret" ]];
then ssh $server "hostname ; uptime";
else echo "invalid user";
fi
