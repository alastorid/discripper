#!/bin/bash
{
  echo $(date)

  echo ">>>Disk found"
  echo ">>>Setting the title..."

  title=$(makemkvcon -r info)
  title=`echo "$title" | grep "DRV:0\+"`
  title=${title:53}
  len=${#title}-12
  title=${title:0:$len}

  if [[ -z $title ]]; then
    echo ">>>Couldn't set the title - No disk found"
    echo ">>>Exit->"
    exit;
  else
    echo ">>>Title set: $title"
    echo ">>>Starting ripping..."

    makemkvcon --minlength=4800 -r --decrypt --directio=true mkv disc:0 all /home/user/share > /dev/null

    mv "/home/user/raid/share/"*.mkv "/home/user/raid/share/"$title.mkv
    mv "/home/user/raid/share/"$title.mkv "/home/user/raid/share/Movies"

    eject
    echo ">>>title: $title.mkv created."

fi
} &>> "/home/user/autorip.log"