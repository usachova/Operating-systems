#!/bin/bash

file=$1
trash=/home/.trash
trlog=/home/.trash.log

if [[ $# != 1 || ! -d $trash || ! -f $trlog ]]
then
	echo "error"
	exit 1
fi

for line in $(grep -s $file $trlog)
do
	path=$(awk -F" " "{ print $1 }" <<< $line)
	nameoff=$(awk -F" " "{ print $2 }" <<< $line)
	pathoff="$trash/$nameoff"
	if [ -f $pathoff ]
	then
		echo "Do you want to untrash file $nameoff? (y/n)"
		read answer
		if [ $answer == "y" ]
		then
			if [ -d $(dirname "$path") ]
			then
				ln $pathoff $path
			else 
				echo "directory does not exist"
				ln $pathoff /home/$file
			fi
			rm $pathoff
		fi
	fi
done
