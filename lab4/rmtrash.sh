#!/bin/bash

file=$1
trash=/home/.trash
trlog=/home/.trash.log

if [[ $# != 1 || ! -f $file ]]
then
	echo "error"
	exit 1
fi

if [[ ! -d $trash ]]
then
	mkdir $trash
	touch $trlog
fi

name=$(date +"%d%m%Y%H%M%S")

ln $file $trash/$name
rm $file && echo $(realpath $file) $name >> $trlog
