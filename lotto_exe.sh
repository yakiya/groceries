#!/bin/bash
# get lotto

while true
do
    go run lottery_generate.go > num.list
    grep -E "8|18" num.list > list.txt
    grep -E "10|1" list.txt > katsu.txt
    
    TTL=`wc -l katsu.txt | awk '{print $1}'`
    
    if [ $TTL == '20' ]; then
        break
    else
        continue
     fi
done
