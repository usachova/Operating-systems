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
		[0-9])
			case $com in
				"+")
					res=$(($res + $str))
					echo "$res"
				;;
				"*")
					res=$(($res * $str))
					echo "$res"
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
