#!/usr/bin/env bash
if [[ "$1" = "-h" ]]
then
        echo "";
        echo "         **************************";
        echo "         ***** CACHE MANAGER ******";
        echo "         **************************";
        echo "";
        echo "    Symfony command: delete the cache folder from the root of a symfony project."
        echo "    > sup_cache";
        echo "";
        echo "    NB: if './var/cache' is not found, doesn't do anything."
        echo "";
elif [[ -d "./var/cache" ]]
then
	rm -rf ./var/cache/*
else
	echo "No cache folder found from here !"
fi
