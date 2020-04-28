#!/usr/bin/env bash
if [[ "$1" = "-h" ]]
then
        echo "";
        echo "         **************************";
        echo "         ****** CONTENT SIZE ******";
        echo "         **************************";
        echo "";
        echo "    Find the size of all folder / files from your current path + total size";
        echo "    > sup_du";
        echo "";
else
	du -hsc ./*
fi
