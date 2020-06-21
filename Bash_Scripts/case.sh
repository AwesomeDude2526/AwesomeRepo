#!/bin/bash

echo "Enter your lucky number"
read n
case $n in
100)
echo "You got 1st prize" ;;
200)
echo "You got 2nd prize" ;;
300)
echo "You got 3rd prize" ;;
*)
echo "Sorry, try for the next time" ;;
esac
