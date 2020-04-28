#!/usr/bin/env bash
if [[ "$1" = "-h" ]]
then
    echo "";
    echo "         **************************";
    echo "         ****** FIND MANAGER ******";
    echo "         **************************";
    echo "";
    echo "    Recursive search from the current folder, use:"
    echo "    > sup_find [FOO]                 (find all files with [FOO] inside)"
    echo "    > sup_find [FOO] .[BAR]          (find all .[BAR] files with [FOO] inside)"
    echo "    > sup_find [FOO] [NAME].[BAR]    (find all [NAME].[BAR] files with [FOO] inside)"
    echo "    > sup_find -f [FOO]              (locate all *[FOO]* files) (not case sensitive)"
    echo "";
elif [[ "$1" = "" ]]
then
	echo "Please enter an input !"
elif [[ "$1" = "-f" ]]
then
	if [[ ! -z "$2" ]]
	then
		find ./ -type f -iname "*$2*" -exec readlink -f {} \;
	fi
elif [[ -z "$2" ]]
then
	echo "Findind all files with '$1' inside:"
	grep -nr --exclude="*\.svn*" --color=auto "$1" *
elif [[ ${2:0:1} = "."  ]]
then
    echo "Findind *$2 files with '$1' inside:"
	grep -nr --exclude=".svn" --include=*$2 --color=auto "$1" *
else
    echo "Findind $2 files with '$1' inside:"
	grep -nr --exclude=".svn" --include=$2 --color=auto "$1" *
fi
