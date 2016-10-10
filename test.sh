#!/bin/bash

while read line
do
    sed -i "s//"
    printf "%s\n" "$line"
done < "$1"
