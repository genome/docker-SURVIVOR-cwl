#!/bin/bash

set -o pipefail
set -o errexit
set -o nounset

# uncompress files as needed
for i in $(echo ${1} | tr "," "\n"); do
    if [[ $i == *.gz ]]; then
        cp "$i" .
        name=$(basename "$i")
        gunzip "$name"
        name=$(echo "$name" | sed 's/\(.*\)\.gz/\1/')
        i="$(pwd)/$name"
    fi
    echo "$i" >> vcfs.list
done

/usr/bin/SURVIVOR merge vcfs.list ${2} ${3} ${4} ${5} ${6} ${7} ${8}