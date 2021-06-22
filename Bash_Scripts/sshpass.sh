#!/bin/bash

echo "Insert Password for Servers"

read -s PASS

for i in $(cat hosts1);
do
	sshpass -p $PASS ssh $i "hostname; uptime";
done
