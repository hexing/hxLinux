bash_prompt_command() {
	RTN=$?
	smiley=$(smiley $RTN)
	smileyc=$(smileyc $RTN)
}
PROMPT_COMMAND=bash_prompt_command
            
smiley() {
	if [ $1 == 0 ] ; then
		echo ":)"
	else
		echo ":("
	fi
}
smileyc() {
	if [ $1 == 0 ] ; then
		echo $GREEN
	else
		echo $RED
	fi
}
                                                                    
if [ $(tput colors) -gt 0 ] ; then
	RED=$(tput setaf 1)
	GREEN=$(tput setaf 2)
	RST=$(tput op)
fi
PS1="\[\$smileyc\]\$smiley \$RTN$PS1\[$RST\]"
