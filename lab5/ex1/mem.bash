#!/bin/bash

num=(1,2,3,4,5,6,7,8,9,10)
arr=()

echo "" > report.log

while true
do
	cnt=0
	arr+=(${num[@]})
	let cnt++
	if [[ $cnt == 10000 ]]
	then
		echo "${#arr[@]}" >> report.log
		cnt=0
	fi
done
