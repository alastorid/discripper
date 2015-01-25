#!/bin/bash
{
	
	echo $(date)
	
	isEmpty=$(fdisk -l /dev/sr0) 

	if [ -z "$isEmpty" ]; then
		echo ">>>Completed (or No disk found)"
		exit
	fi

	echo ">>>Disk found"
	echo ">>>Setting the title..."

	title=$(makemkvcon -r info disk:0)
	title=`echo "$title" | grep "DRV:0\+"`
	title=${title:53}
	len=${#title}-12
	title=${title:0:$len}

	echo ">>>Title set: $title"
	echo ">>>Starting ripping..."

	makemkvcon --minlength=4800 -r --decrypt --directio=true mkv disc:0 all /home/share > /dev/null

	mv /home/share/Movies/title00.mkv /home/share/Movies/$title.mkv
	eject
	echo ">>>title: $title.mkv created."
} &>> "/user/.diskripper.log" &
