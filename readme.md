Radio Saturn Scripts
v2.6
by Andrew Bell

Scripts to stream Radio Saturn: sound from Spotify via pulseaudio, visuals from Goom via Gstreamer. Much hacked together. Originally a one-liner. Grew legs.

Installation
------------

I usually put scripts into /usr/local/scripts, then symlink them to /usr/local/bin. You'll also need to install anything Gstreamer 1.0, screen, xvfb, x11vnc, DevilsPie, ii and a whole load of other stuff. I'd make a list, but I'm too lazy. Maybe some time in the future. Everything in the ./home directory goes into your home directory. I don't think I hard-coded /home/andrew (my own home dir) into any of the scripts; so long as $HOME is set correctly, this should work. You'll also need to create "~/Documents/Radio Saturn", and put botro.txt in there.

I'll clean this up at some point.

Configuration
-------------

Put your stream credentials (url and stream key) into stream.sh. Also, if you want to use the IRC bot, these go into radio_saturn.sh.

Running
-------

Only two of these scripts need to be invoked by the user. The rest are dependencies.
radio_saturn.sh -- main script for visualisation, now playing, IRC bot, etc. If you want to start the IRC bot, add the --irc option.
stream.sh -- stream sound, and visualisation from xvfb, to wherever.

Happy streaming!
