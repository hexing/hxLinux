#!/bin/sh

while [ true ]
do
	gconftool-2  -s /desktop/gnome/background/picture_filename -t string "`ls /tmp/wallpaper/*.jpg | shuf -n 1`" -s  /desktop/gnome/background/picture_options zoom
	sleep 600
done
