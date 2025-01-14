#!/bin/bash

lastBUdate=$(ls /home | grep -E "^Backup-" | sort -n | tail -1 | sed "s/Backup-//")
lastBU="/home/Backup-$lastBUdate"
now=$(date +"%Y-%m-%d")
nows=$(date -d $now +"%s")
lasts=$(date -d $lastBUdate +"%s")
diff=$(echo "(${nows} - ${lasts}) / 60 / 60 / 24" | bc)
report=/home/backup-report
source=/home/source

if (( $diff > 7 )) || [[ -z "$lastBUdate" ]]
then
	mkdir "/home/Backup-${now}"
	for x in $(ls $source)
	do
		cp "$source/$x" "/home/Backup-$now"
	done
	echo -e "Backup-$now was created:\n$(ls $source | sed "s/^/\t/")" >> $report
else
	chs=""
	for x in $(ls $source)
	do
		if [[ -e "$lastBU/$x" ]]
		then
			nowsize=$(wc -c "/home/source/$x" | awk '{ print $1 }')
			busize=$(wc -c "$lastBU/$x" | awk '{ print $1 }')
			sdiff=$(echo "$nowsize - $busize" | bc)
			if (( $sdiff != 0 ))
			then
				mv "$lastBU/$x" "$lastBU/$x.$now"
				cp "$source/$x" "$lastBU"
				chs="$chs\n\t $x $x.$now"
			fi
		else
			cp  "$source/$x" "$lastBU"
			chs="${chs}\n\t${x} copied"
		fi
	done
	chs=$(echo $chs | sed "s/^\n//")
	if [[ ! -z $chs ]]
	then
		echo -e "Backup-$lastBUdate updated:\n$chs" >> $report
	fi
fi
