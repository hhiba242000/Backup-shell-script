#!/bin/bash

mkdir -p $1
touch "$2"/logfile.new "$2"/logfile.last

count=$(find $2 -mindepth 1 -maxdepth 1 -type d -name "20*" | wc -l)
echo "INITIAL COUNT OF BACKUPS = $count"

ls -IR -F --full-time $1 > "$2"/logfile.last

if cmp -s "$2"/logfile.new "$2"/logfile.last; then
	echo "--NO NEW MODIFICATIONS--"
else 
	echo "--SOME MODIFICATONS WERE FOUND--"
	if [ $count -ge $3 ]; then 
		echo "NO MORE NEW BACKUPS, ONLY "$4" ARE ALLOWED"
		echo "Replacing oldest backup with the newest..."
		find $2 -name "20*" | sort | head -n 1 | xargs rm -r 
	fi
	datename=$(date +"%Y-%m-%d-%H-%M-%S")
	mkdir $2/"$datename"
	cp --verbose -r $1  $2/"$datename"
	echo | cat $2/logfile.last > $2/logfile.new	
	#count=`expr $count + 1`	

fi