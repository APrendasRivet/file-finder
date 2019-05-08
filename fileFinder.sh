#!/bin/bash

if [ $# -lt 3 ];then
	echo "
	usage: path fileExtention pattern
	see: https://www.grymoire.com/Unix/Regular.html
	" | grep . --color 
	exit -1
fi

_PATH=$1

_EXT=$2

_REGEX=$3

_LIST=""

echo "Pattern: $_REGEX"

for file in $(find $_PATH -name "*.$_EXT");do 
	file=$( echo $file | awk '{gsub("//", "/"); print $0" "}')
    echo "
    *** File is $file ***
    " | grep . --color	

    cat $file | tr -d '\n' | grep -i -E --color $_REGEX

    c=$( cat $file | tr -d '\n' | grep -i -c -E $_REGEX )
    if [ $c -gt 0 ];then
    	echo "
    	### 	match 	###
    	" 
    	_LIST+=$file
    fi
done

echo "
*** files found ***
"
for file in $_LIST; do
	echo "file: $file" | grep . --color
done
