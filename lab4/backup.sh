#!/bin/bash

lastBUdate=$(ls /home | grep -E "^Backup-" | sort -n | tail -1 | sed "s/Backup-//")
lastBU="/home/Backup-$lastBUdate"
now=$(date +"%Y-%m-%d")
diff=$(echo "($(date -d "$now" +"%s") - $(date -d "$lastBUdate" +"%s") / 24 / 60 / 60)" | bc)
report=/home/backup-report
source=/home/source

if [[ $diff > 7 ]] || [[ -z "$lastBUdate" ]]
then
	mkdir "/home/Backup-$now"
	for x in $(ls $source)
	do
		cp "$source/$x" "/home/Backup-$now"
	done
	echo -e "Backup-$now was created:\n$(ls $source | sed "s/^/\t/")" >> $report
else
	chs=""
	for x in $(ls $source)
	do
		if [[ -f "$lastBU/$x" ]]
		then
			nowsize=$(wc -c "/home/source/$x" | awk "{ print $1 }")
			busize=$(wc -c "$lastBU/$x" | awk "{ print $1 }")
			if (( $(echo "$nowsize - $busize" | bc) != 0 ))
			then
				mv "$lastBU/$x" "$lastBU/$x.$now"
				cp "$source/$x" "$lastBU"
				chs="$chs\n\t $x $x.$now"
			fi
		else
			cp  "$source/$x" "$lastBU"
			chs="$chs\n\t$x copied"
		fi
	done
	chs=$(echo $chs | sed "s/^\n//")
	if [[ ! -z $chs ]]
	then
		echo -e "Backup-$lastBUdate updated:\n$chs" >> $report
	fi
fi
