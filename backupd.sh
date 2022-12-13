#!/bin/bash

touch "$2"/logfile.new "$2"/logfile.last

count=$(find $2 -mindepth 1 -maxdepth 1 -type d -name "20*" | wc -l)
echo "INITIAL COUNT OF BACKUPS = $count"
while true
do
	ls -IR -F --full-time $1 > "$2"/logfile.last
	if cmp -s "$2"/logfile.new "$2"/logfile.last; then
		echo "--NO NEW MODIFICATIONS--"
		sleep 5
	else 
		echo "SOME MODIFICATONS WERE FOUND"
		sleep 2
		if [ $count -ge $4 ]; then 
			echo "NO MORE NEW BACKUPS, ONLY "$4" ARE ALLOWED"
			echo "Replacing oldest backup with the newest..."
			find $2 -name "20*" | sort | head -n 1 | xargs rm -r 
			sleep 2
		fi
			datename=$(date +"%Y-%m-%d-%H-%M-%S")
			mkdir $2/"$datename"
			cp --verbose -r $1  $2/"$datename"
			echo | cat $2/logfile.last > $2/logfile.new	
			count=`expr $count + 1`	

	fi
	sleep $3

done

	