#!/usr/bin/env bash

function older_than {
    [ $(stat -c %Y "$1") -lt $(stat -c %Y "$2") ]
}

function link {
    echo "linking" 
    gcc -o "$1" *.o
}

has_compiled=1

if [ "$#" -ne 1  ]; then 
    echo "Usage: $ $0 name-of-program" ; exit 
fi

if [ -z `ls *.c 2> /dev/null` ]; then 
    echo "Current directory does not contain any c-files"; exit
fi

for cfile in *.c; do
    objfile=${cfile%.*}.o
        
    if [ ! -f "$objfile" ] || older_than "$objfile" "$cfile" ; then 
        echo "compiling $cfile, creating new objectfile $objfile " 
        gcc -c -o $objfile $cfile || { echo "gcc error, exiting"; exit; }
        has_compiled=0  
    fi    
done

if [ ! -f "$1" ] || [ $has_compiled ]; then
    link "$1"
fi   
