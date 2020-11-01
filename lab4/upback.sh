#!/bin/bash

lastBUdate=$(ls /home | grep -E "^Backup-" | sort -n | tail -1 | sed "s/^Backup-//")
lastBU="/home/Backup-$lastBUdate"

if [[ -z "$lastBUdate" ]]
then
	echo error
	exit 1
fi

restore=/home/restore

if [[ ! -d "$restore" ]]
then
	mkdir $restore
else
	rm -r $restore
	mkdir $restore
fi

for x in $(ls $lastBU | grep -Ev "[0-9]{4}-[0-9]{2}-[0-9]{2}$")
do
	cp "$lastBU/$x" "$restore/$x"
done
