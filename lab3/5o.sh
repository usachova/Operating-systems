#!/bin/bash

com="+"
ans=1
tail -f pipe |
while true
do
	read str
	case $str in
		"+")
			com="$str"
			echo "$str"
		;;
		"*")
			com="$str"
			echo "$str"
		;;
		"QUIT")
			killall tail
			exit 0
		;;
		[0-9]*)
			case $com in
				"+")
					ans=$(($ans + $str))
					echo "$ans"
				;;
				"*")
					ans=$(($ans * $str))
					echo "$ans"
				;;
			esac
		;;
		*)
			killall tail
			echo "error!"
			exit 1
		;;
	esac
done
