#!/bin/bash

# There are two ways to write a function. Call the funtion using its name ###

awesome () {
touch /root/file
mkdir /root/directory
cat /etc/hosts > /root/file
}

amazing () {
ifconfig > /root/ifconfig.txt
service vsftpd stop
}

amazing
awesome



### Second way to write a function ###

function myfunc() {
    echo "Hello $1"
}
myfunc "John"
myfunc "Kelly"


