#!/bin/bash

for i in server1 server2 server3;
do ssh user@$i "sudo tar -czvf messages.tar.gz /var/log/messages";
done

for i in $(cat hosts);
do ssh $i "hostname; uptime";
done

for i in `cat hosts`;
do ssh $i "hostname; uptime";
done

for i in file1 file2 file3;
do sed -i s/oldword/newword/g $i;
done
