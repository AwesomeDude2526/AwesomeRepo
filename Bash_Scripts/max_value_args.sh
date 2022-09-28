#!/bin/bash

#Check if the number of arguments passed is zero
if [ "$#" = 0 ]
then
    #Script exits if no
    #arguments passed
    echo "No arguments passed."
    exit 1
fi
  
#Initialize maxvalue with 
#the first argument
maxvalue=$1
  
#Loop that compares maxvalue with the 
#passed arguments and updates it
for arg in "$@"
do
    if [ "$arg" -gt "$maxvalue" ]
    then
        maxvalue=$arg
    fi
done
echo "Largest value among the arguments passed is: $maxvalue"
