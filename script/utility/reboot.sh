#!/bin/sh

HX_BIN=$(dirname "$0")
sh $HX_BIN/canShutdown.sh || exit

reboot $*
