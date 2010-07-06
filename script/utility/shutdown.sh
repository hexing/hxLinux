#!/bin/sh

HX_BIN=/usr/local/sbin
sh $HX_BIN/canShutdown.sh || exit

[ -z "$*" ] && ARGV="-h +0" || ARGV="$*"
shutdown $ARGV
