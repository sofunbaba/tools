#!/bin/bash

if [ ! -d ~/.recyle ]; then
    mkdir ~/.recyle
fi

RM="/bin/mv -f"

if [ $# -lt 1 ]; then
    echo "Usage: rm [OPTION] [FILE or DIR]"
    echo "del FILE or DIR to ~/.recyle"
    echo "OPTIONS:"
    echo "--real: direct del FILE"
fi

options=""
files=""
suffix=`date +%Y-%m-%d-%k-%M-%S-%N`

for file in "$@"
do
if [ "${file:0:1}" = '-' ]; then
    if [ "$file" = "--real" ]; then
        RM="/bin/rm -rf "
    fi
    # options+="$file "
else
    files+="$file "
fi
done

for file in $files
do
    # strip the last '/' for dirpath
    while ([ -d "$file" -a "${file:${#file}-1:1}" = '/' ])
    do
        file=${file:0:${#file}-1}
    done

    # get the filename from filepath
    if [ -f "$file" ]; then
        file=$(basename $file)
    fi

    # mv file only when the file or dir exist.
    if [[ -e "$file" ]]; then
        $RM $options $file ~/.recyle/$file.$suffix
    fi
done


