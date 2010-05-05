confirm() #yes=0 no=1
{
	(( $# < 1 )) && return 99
	echo -e "$*"
	read line

	[[ -z $line ]] && return #default value
	[[ 'yes' =~ "$line" ]] || [[ y =~ "$line" ]] && return
	[[ 'no' =~ "$line" ]] || [[ n =~ "$line" ]] && return 1
	confirm "$*"
}
