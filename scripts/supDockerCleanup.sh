#!/usr/bin/env bash
if [[ "$1" = "-h" ]]
then
        echo "";
        echo "         ***********-***************";
        echo "         ***** DOCKER CLEANUP ******";
        echo "         **************************";
        echo "";
        echo "    Stop & clean your docker instances"
        echo "    > sup_docker_cleanup";
        echo "";
else
    docker stop $(docker ps -qa)
    docker system prune -fa
    docker rm $(docker ps -q -f status=exited)
    docker volume rm $(docker volume ls -q)
fi

