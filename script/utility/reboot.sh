#!/bin/sh

/usr/local/sbin/canShutdown.sh || exit

reboot $*
