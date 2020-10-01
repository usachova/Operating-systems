#!/bin/bash

ans=""

for pid in $(ps -A -o pid)
do
	statf="/proc/"$pid"/status"
	schf="/proc/"$pid"/sched"
	ppid=$(grep -Ehsi "ppid:\s(.+)" $statf | grep -o "[0-9]\+")
	ser=$(grep -Ehsi "se.sum_exec_runtime" $schf | grep -o "[0-9]\+")
	ns=$(grep -Ehsi "nr_switches" $schf | grep -o "[0-9]\+")
	ART=$((ser/ns))
	if [[ -n $ppid ]]
		then ans=$ans"ProcessID="$pid" : Parent_ProcessID="$ppid" : Average_Running_Time="$ART
	fi
done

echo "$ans" | sort -t " " -k2 > ans4
