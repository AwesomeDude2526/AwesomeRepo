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



##KEY AND VALUES
declare -A myArray=([one]=un [two]=deux [three]=trois)
echo ${myArray[*]}
deux trois un
echo ${myArray[one]}
un

unset myArray[one]
echo ${myArray[*]}
deux trois

unset myArray
echo ${myArray[*]}


#Print Associative Array Values
myAssociativeArray=([a]=123 [b]=456)
for value in "${myAssociativeArray[@]}"; do echo "$value"; done
456
123

# Print Associative Array Keys
myAssociativeArray=([a]=123 [b]=456)
for keys in "${!myAssociativeArray[@]}"; do echo "$keys"; done
b
a


#Print the Array Length
myArray=(a b c d)
echo "myArray contain ${#myArray[*]} elements"
myArray contain 4 elements
