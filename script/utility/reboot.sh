#!/bin/sh

HX_BIN=/usr/local/sbin
sh $HX_BIN/canShutdown.sh || exit

reboot $*
