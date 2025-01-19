#!/bin/bash

for i in $(seq 1 10); do
    # echo $i
    clear
    curl http://10.10.20.46:3000/code_snippet | jq
    sleep 1
done
