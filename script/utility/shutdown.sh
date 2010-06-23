#!/bin/sh

/usr/local/sbin/canShutdown.sh || exit

[ -z "$*" ] && ARGV="-h +0" || ARGV="$*"
shutdown $ARGV
