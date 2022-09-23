#!/bin/bash

array=( one two three )

files=( "/etc/passwd" "/etc/group" "/etc/hosts" )

limits=( 10 20 26 39 48)

## Arrays can be declared using the declare command as well
declare -A fruits
fruits[south]="Banana"
fruits[north]="Orange"
fruits[west]="Passion Fruit"
fruits[east]="Pineapple"


## This will print all the values in the arrays due to the @ sign
printf "%s\n" "${array[@]}"
printf "%s\n" "${files[@]}"
printf "%s\n" "${limits[@]}"
printf "%s\n" "${fruits[@]}"


## Print a particular element in the array using index or key

printf "Group file in Linux or Unix: %s\n" "${files[1]}"
printf "Popular fruit in the South is: %s\n" "${fruits[south]}"


## Run Array in a For Loop
for i in "${arrayName[@]}"
do
   echo $i
done
