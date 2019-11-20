
if [ "$1" = "-h" ]
then
        echo "";
        echo "         **************************";
        echo "         ****** FIND MANAGER ******";
        echo "         **************************";
        echo "";
	echo "Recursive search from the current folder, use:"
	echo "  - myfind [STRING]                 (find all files with [STRING] inside)"
	echo "  - myfind [STRING] .[EXT]          (find all .[EXT] files with [STRING] inside)"
	echo "  - myfind [STRING] [NAME].[EXT]    (find all [NAME].[EXT] with [STRING] inside)"
	echo "  - myfind -f [NAME]                (locate all *[NAME]* files) (not case sensitive)"
        echo "";
elif [ "$1" = "" ]
then 
	echo "Please enter hey facking eynpoute !"
elif [ "$1" = "-f" ]
then
	if [[ ! -z "$2" ]]
	then
		find ./ -type f -iname "*$2*" -exec readlink -f {} \;
	fi
elif [[ -z "$2" ]]
then
	echo "Findind all files with '$1' inside:"
	grep -nr --exclude="*\.svn*" --color=auto "$1" *
elif [ ${2:0:1} = "."  ]
then
        echo "Findind *$2 files with '$1' inside:"
	grep -nr --exclude=".svn" --include=*$2 --color=auto "$1" *
else
        echo "Findind $2 files with '$1' inside:"
	grep -nr --exclude=".svn" --include=$2 --color=auto "$1" *
fi
