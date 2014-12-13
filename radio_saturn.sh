#!/bin/bash
#ncmpcpp
export network="irc.ponychat.net"
export channel="#bronystate"
export netpath="$HOME/irc/$network"
export chanpath="$netpath/$channel"
if [ "$1" == "--irc" ]
then
	if ! pidof ii > /dev/null
	then
		ii -s $network -n Radio_Bot -f "Radio Saturn Bot" &
	fi
	sleep 3
	echo "/j nickserv identify somepass" > "$netpath/in"
	echo "/j $channel" > "$netpath/in"
	sleep 2
	cat /home/andrew/Documents/Radio\ Saturn/botro.txt > "$chanpath/in"
fi

tput civis
echo -e "\e[1;33;40m"; clear; figlet < /home/andrew/rs_intro.txt; read
screen -c /home/andrew/bs_radio.screen.conf
