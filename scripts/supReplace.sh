#!/usr/bin/env bash
if [[ "$1" = "-h" ]]
then
	echo "";
	echo "         **************************";
	echo "         **** REPLACE MANAGER *****";
	echo "         **************************";
	echo "";
	echo "     Replace all occurence of [FOO] found by [BAR] found inside all the files in the current folder";
	echo "     > sup_replace [FOO] [BAR]";
	echo "";
	echo "     NB: DO NOT FORGET TO ESCAPE QUOTES (' & \")";
	echo "";
elif [[ ! -z "$1" ]] && [[ ! -z "$2" ]]
then
	perl -e "s|$1|$2|g;" -pi $(find ./ -type f)
else
	echo "Need more arguments";
fi
