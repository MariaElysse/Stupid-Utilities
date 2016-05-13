#!/bin/bash 
tmp=$(mktemp -d)
gcc -c "$1" -o "$tmp/tmp.o"
objdump -d "$tmp/tmp.o"

