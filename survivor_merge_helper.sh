#!/bin/bash

set -o pipefail
set -o errexit

# uncompress files as needed
for i in $(echo ${3} | tr "," "\n"); do
    if [[ $i == *.gz ]]; then
        gunzip "$i"
        i=$(echo "$i" | sed 's/\(.*\)\.gz/\1/')
    fi
    echo "$i" >> vcfs.list
done

echo "/usr/bin/SURVIVOR merge vcfs.list ${4} ${5} ${6} ${7} ${8} ${9} ${10}"