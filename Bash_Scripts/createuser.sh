#!/bin/bash


### Creating users on remote server using arguments ###


SERVER=$1
USER1=$2

echo -e "\n######## Creating $USER1 on $SERVER #######\n"

ssh $SERVER "useradd $USER1"
ssh $SERVER "echo 123 | passwd --stdin $USER1"

echo -e "\n######## Verify $USER1 on $SERVER #######\n"
ssh $SERVER "hostname; id $USER1 ; grep $USER1 /etc/passwd"

echo -e "\n######## Congrats! $USER1 created on $SERVER #######\n"
