#!/usr/bin/env bash

cc=gcc

function compile {
    objfile=$1
    cfile=$2
    echo "Compiling $cfile, creating new objectfile $objfile " 
    $cc -c -o $objfile $cfile 
}

function link {
    echo "Linking" 
    $cc -o "$1" *.o
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
    if [ ! -f "$objfile" ] || [ "$objfile" -ot "$cfile" ] ; then 
        compile $objfile $cfile || { echo "gcc error, exiting"; exit; }
        has_compiled=0  
    fi    
done

if [ ! -f "$1" ] || [ $has_compiled ]; then
    link "$1"
fi   
