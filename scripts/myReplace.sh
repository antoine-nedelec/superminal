if [ "$1" = "-h" ]; then
	echo "";
	echo "         **************************";
	echo "         **** REPLACE MANAGER *****";
	echo "         **************************";
	echo "";
	echo "     Replace all occurence of [FOO] found by [BAR] for all the files in the current folder";
	echo "     -> NB: DO NOT FORGET TO ESCAPE QUOTES (' & \")";
	echo "";
	echo "     usage: 'myreplace FOO BAR'";
	echo "";
elif [[ ! -z "$1" ]] && [[ ! -z "$2" ]]; then
	perl -e "s|$1|$2|g;" -pi $(find ./ -type f)
else
	echo "Need more arguments";
fi
