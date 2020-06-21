#!/bin/bash

if yum list installed httpd;
then echo "package is installed";
else yum install httpd -y;
fi



if yum list installed $*;
then echo "package is installed";
elif [ `df -h / | tail -1 | awk '{print $4}' | sed s/G//g` -gt 2 ]
then echo "space is greater than 2GB";
else echo "not enough space in root directory";
fi



for i in $(cat hosts);
do ssh $i "
if yum list installed nfs-utils;
then echo "package is installed";
elif [ `df -h / | tail -1 | awk '{print $4}' | sed s/G//g` -gt 2 ]
then echo "space is greater than 2GB";
else echo "not enough space in root directory";

fi
"
done
