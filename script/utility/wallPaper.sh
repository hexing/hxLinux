#!/bin/sh

while true;
do
	feh --bg-scale "$(find ~/.wallpaper -name *.jpg | shuf -n 1)"
	sleep 15m
done
