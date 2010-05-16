#!/bin/sh

F_TARGET='/etc/inputrc'
TAG_BEG='###<enable_Bash_history_search>'
TAG_END='###</enable_Bash_history_search>'
MSG='enable Bash history search'
ask
if (( 0 == $? )); then
	sed_awk_app
fi

#[ -h /bin/sh ]
#[ -L /bin/sh ] && [ -x /bin/dash ] && ln -fs /bin/dash /bin/sh
