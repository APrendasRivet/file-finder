#!/bin/bash

if [ $# -lt 3 ];then
	echo "Fail execution: params are required
	EXAMPLE> ./fileFinder.sh startingPath FileExtention [expressions-1, expressions-2, ..., N]
	" | grep . --color 
	
	exit -1
fi

_PATH=$1

_EXT=$2

_REGEX="($3)"

_LIST=""


for param in ${@:4}; do
	_REGEX+="|($param)"
done

echo "priting REGEX: $_REGEX"

for file in $(find $_PATH -name "*.$_EXT");do 
    echo "
    *** File is $file ***
    "
    cat $file | grep -i -E --color $_REGEX

    c=$( cat $file | grep -i -E -c $_REGEX )
    if [ $c -gt 0 ];then
    	echo "
    		### 	match 	###
    		"
    	_LIST+=$( echo "$(pwd)/$file" | awk '{gsub("//", "/");gsub("/./", "/"); print $0" "}')
    fi
done

echo "
		*** printing files that contain matches for the expressions ***
	 "

for element in $_LIST; do
	echo "file: $element" | grep . --color
done
