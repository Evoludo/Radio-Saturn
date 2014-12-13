#!/bin/bash

newdisp=':99'
Xvfb $newdisp -screen 0 640x480x16 -fbdir /home/andrew/fb &
olddisp=$DISPLAY
export DISPLAY=$newdisp
sleep 1
devilspie &
xfwm4 --daemon
gnome-terminal & 
x11vnc -display $newdisp.0 -ncache 10 -ncache_cr -forever &
sleep 2
DISPLAY=$olddisp
#pavucontrol & 
vncviewer localhost &
echo "X server started for streaming on $newdisp"
while true; do sleep 60; done
