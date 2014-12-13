#!/bin/bash

#(mplayer -msglevel all=-1 -vo null /media/TARDIS/Music/elevator.mp3 < /dev/null; mplayer -msglevel all=-1 -vo null -loop 0 /media/TARDIS/Videos/Miscellaneous/Brony\ Movie\ Night\ Intermission.mp4 < /dev/null &) & 
tput civis
#echo -e "\e]0;  NOW PLAYING:\a"
screen -X title "  NOW PLAYING:"
sleep 0.2
switch=-1
ponyheights=(15 18 19 20 21 22 23)
while true
do 
	fog=$RANDOM
	bag=$RANDOM
	bold=$RANDOM
	#sl=$RANDOM
	#pony=$RANDOM
	let "fog %= 8"
	let "bag %= 8"
	let "bold %= 2"
	if [[ $fog == $bag ]]
	then 
		let "bag -= 1"
		let "bag %= 7"
	fi
	#let "sl %= 2"
	#let "pony %= 2"
	let "switch += 1"
	let "switch %= 4"
	echo -e "\e[0;38;48m"
	clear
	if [[ $switch == 0 ]]
	then 
		echo -e "\e[${bold};3${fog};4${bag}m"
		clear
		echo
		toilet "        Radio Saturn        " -f pagga.tlf
		max=20
		let n=max+1
		while [ $n -gt $max ]
		do
			buff=`fortune | cowsay`
			n=`echo "$buff" | wc -l`
		done
		echo "$buff"
	elif [[ $switch == 2 ]]
	then
		echo
		toilet "        Radio Saturn        " -f pagga.tlf
		let "i = $RANDOM % 7"
		ponysay -o -r height=${ponyheights[i]}
	else
		CACA_DRIVER=x11 CACA_GEOMETRY=80x28 setsid bash -c 'gst-launch-1.0 -q pulsesrc ! goom ! video/x-raw, width=320, height=220, frame-rate=1/1 ! queue ! videoconvert ! cacasink & echo "$!" > .gst.pid' > /dev/null 2>&1
		sleep 120
		kill `cat .gst.pid`
		tput civis
		continue
	fi
	sleep 20
done
