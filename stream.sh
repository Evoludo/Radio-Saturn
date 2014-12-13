#!/bin/bash

if [[ $# = 0 ]]; then
	exec >&2
	echo "Usage: $(basename $0) <input file> [hh:mm:ss]"
	echo "Where:"
	echo "  <input file> is the media you want to stream"
	echo "  [hh:mm:ss] is the a time offset in the media to stream from"
	exit 1
fi

echo "1: V:  64kbps; A: 256kbps"
echo "2: V: 192kbps; A: 128kbps"
echo "3: V: 256kbps; A:  64kbps"
echo "4: V: 1024kbps; A: 320kbps"
echo "5: V:  64kbps; A: 128kbps"

read bitrates
if ! [[ "$bitrates" =~ ^[0-9]+$ ]]; then
	exec >&2
	echo "Choice must be a number"
	exit 1
fi

case "$bitrates" in
	1)
		vb=64
		ab=256
		;;
	2)
		vb=192
		ab=128
		;;
	3)
		vb=256
		ab=64
		;;
	4)
		vb=1024
		ab=320
		;;
	5)
		vb=64
		ab=128
		;;
	*)
		exec >&2
		echo "Invalid choice"
		exit 1
esac


echo "1: Saturn Ustream"
echo "2: Saturn Mips.tv"
echo "3: BronyState UStream 29/09/2013"
echo "4: BronyState UStream Emerald"
echo "5: BronyState Ustream Cookie"
echo "6: BronyState Mips.tv 20130625"
echo "7: BronyState Mips.tv 20131014"

read streamchoice
if ! [[ "$streamchoice" =~ ^[0-9]+$ ]]; then
	exec >&2
	echo "Choice must be a number"
	exit 1
fi


case "$streamchoice" in
	1)
		url=""
		stream=""
		endbit="$url/$stream flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"
		;;
	2)
		url=""
		stream=""
		endbit="$url/$stream app=live tcUrl=$url swfUrl=$url flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"
		;;
	3)
		url=""
		stream=""
		endbit="$url/$stream flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"
		;;
	4)
		url=""
		stream=""
		endbit="$url/$stream flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"
		;;
	5)
		url=""
		stream=""
		endbit="$url/$stream flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"
		;;
	6)
		url=""
		stream=""
		endbit="$url/$stream app=live tcUrl=$url swfUrl=$url flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"
		;;
	7)
		url=""
		stream=""
		endbit="$url/$stream app=live tcUrl=$url swfUrl=$url flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"
		;;
	*)
		exec >&2
		echo "Invalid choice"
		exit 1
esac


#ffmpeg-new -threads 4 $([[ $# = 2 ]] && echo "-ss $2") -i "$1" -vol 1024 -strict -2 -vcodec libx264 -vb 150k -acodec aac -ab 64k -ar 44100 -f flv "$url/$stream app=live tcUrl=$url swfUrl=$url flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"
#ffmpeg -threads 4 -f video4linux2 -i /dev/video0 -f alsa -i pulse -vol 256 -strict -2 -vcodec libx264 -vb 200k -acodec aac -ab 128k -ar 44100 -f flv "$url/$stream app=live tcUrl=$url swfUrl=$url flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"
#ffmpeg -async 10000 -threads 4 -itsoff:et -00:00:00.2 -f x11grab -r 20 -s 1600x900 -i "$1".0 -f alsa -i pulse -vol 256 -strict -2 -vcodec libx264 -vb 150k -acodec aac -ab 128k -ar 44100 -f flv "$url/$stream app=live tcUrl=$url swfUrl=$url flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"
#ffmpeg -threads 4 -itsoffset -00:00:00.2 -f x11grab -r 15 -s 640x480 -i "$1".0 -f alsa -i pulse -strict -2 -vcodec libx264 -vb 200k -acodec aac -ab 128k -ar 44100 -f flv "$url/$stream flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"
#avconv -async -1 -threads 1 -f x11grab -r 15 -s 640x480 -i "$1".0 -preset fast -f alsa -i pulse -vol 256 -vcodec libx264 -vb 200k -strict experimental -acodec aac -ab 128k -ar 48000 -f flv "$url/$stream flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"

#avconv -async -1 -threads 1 -f x11grab -r 15 -s 640x480 -i "$1".0 -preset fast -f alsa -i pulse -vcodec libx264 -vb 200k -vf "movie=/home/andrew/saturn_watermark.png [watermark]; [in][watermark] overlay=main_w-overlay_w-10:10 [out]" -strict experimental -acodec aac -ab 128k -ar 44100 -f flv "$endbit" #"$url/$stream app=live tcUrl=$url swfUrl=$url flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"

#avconv -async -1 -threads 1 -f x11grab -r 15 -s 640x480 -i "$1".0 -preset fast -f alsa -i pulse -vcodec libx264 -vb 100k -vf "movie=/home/andrew/saturn_watermark.png [watermark]; [in][watermark] overlay=main_w-overlay_w-10:10 [out]" -strict experimental -acodec aac -ab 128k -ar 44100 -f flv "$url/$stream flashver=FME/2.5\\20(compatible;\\20FMSc\\201.0)"

####### GStreamer

gst-launch-1.0 -vvv \
	ximagesrc show-pointer=0 use-damage=0 display-name=":99" \
		! video/x-raw, framerate="25/1", width=640, height=480, pixel-aspect-ratio="1/1" \
		! videorate \
		! videoconvert \
		! queue \
		! x264enc bitrate=$vb bframes=0 threads=4 \
		! queue \
		! flvmux streamable=true name=mux \
		! rtmpsink location="$endbit" \
	pulsesrc \
		! "audio/x-raw,channels=2" \
		! audioconvert \
		! queue \
		! voaacenc bitrate=$ab \
		! aacparse \
		! mux.


