#!/bin/bash
if [ "$1" = "-h" ]
then
        echo "";
        echo "         **************************";
        echo "         ***** CACHE MANAGER ******";
        echo "         **************************";
        echo "";
        echo "Symfony command: delete the cache folder from the root of a symfony project."
        echo "  NB: if './var/cache' is not found, doesn't do anything."
        echo "";
elif [ -d "./var/cache" ]
then
	rm -rf ./var/cache/*
else
	echo "Wrong folder !"
fi

