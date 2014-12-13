#!/bin/bash

i=0
j=0
current=""
last=""
playlist="/home/andrew/Documents/Radio Saturn/playlist.txt"
date >> "$playlist"

#network="irc.ponychat.net"
#channel="#bronystate"
#netpath="$HOME/irc/$network"
#chanpath="$netpath/$channel"
#ii -s $network -n Radio_Bot -f "Radio Saturn Bot" &
#echo "/j nickserv identify primax" > "$netpath/in"
#echo "/j $channel" > "$netpath/in"
#echo -e "\x02`cat /home/andrew/Documents/Radio\ Saturn/botro.txt`" > "$chanpath/in"

while true
do
	last=$current
	current="`qdbus org.mpris.MediaPlayer2.spotify / org.freedesktop.MediaPlayer2.GetMetadata | grep 'mpris:length\|xesam:artist\|xesam:title' | awk '{ if ($1 ~ "artist") { $1=""; artist = $0 } else if ($1 ~ "title") { $1=""; title = $0 } else if ($1 ~ "length") { len = $2 } } END { seconds = sprintf("%02d", len/1000/1000%60); print "(" int(len/1000/1000/60) ":" seconds ")" artist " -" title}'`"
	if [ $i == 0 ]
	then
		max=`grep -v "^#" /home/andrew/radio_motd.txt | wc -l`
		#echo -e "\e]2;  `grep -v "^#" /home/andrew/radio_motd.txt | tail -n+$(expr $j + 1) | head -n 1`"
		screen -X title "  `grep -v "^#" /home/andrew/radio_motd.txt | tail -n+$(expr $j + 1) | head -n 1`"
		echo -e "\r" | tr -d '\n'; echo "$current" | tr -d '\n' | head -c 78
		let j=(j+1)%max
	fi
	if [ "$last" != "$current" ]
	then
		echo
		echo "$current" | tee -a "$playlist" | tr -d '\n'
		if pidof ii > /dev/null
		then
			(sleep 20; echo -e "\x02NOW PLAYING: `echo $current | sed -e 's/(.*) //'`  " > "$chanpath/in") &
		fi
	fi
	sleep 1
	let i=(i+1)%10
done
