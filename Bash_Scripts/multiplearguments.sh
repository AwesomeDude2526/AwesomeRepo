#!/bin/bash

for i in $@;
do touch $i;
done


for i in $*;
do mkdir $i;
done
