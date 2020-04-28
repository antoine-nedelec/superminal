#!/usr/bin/env bash
if [[ "$1" = "-h" ]]
then
        echo "";
        echo "         ***********-***************";
        echo "         ***** DOCKER KARCHER ******";
        echo "         ***************************";
        echo "";
        echo "    !! Use with caution (Will kill all docker volumes, networks, images & containeres) !!"
        echo "    > sup_docker_cleanup";
        echo "";
else
    docker kill $(docker ps -q)
    echo "delete volumes? (y/n): "
    read volumes
    if [[ $volumes =~ ^[Yy]$ ]]; then
        docker volume rm $(docker volume ls -qf dangling=true)
    fi
    echo "delete networks? (y/n): "
    read networks
    if [[ $networks =~ ^[Yy]$ ]]; then
        docker network ls
        docker network ls | grep "bridge"
        docker network rm $(docker network ls | grep "bridge" | awk '/ / { print $1 }')
    fi
    echo "remove docker images? (y/n): "
    read images
    if [[ $images =~ ^[Yy]$ ]]; then
        docker images
        docker images rmi $(docker images --filter "dangling=true" -q --no-trunc)
        docker images | grep "none"
        docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
    fi
    echo "remove docker containers? (y/n): "
    read containers
    if [[ $containers =~ ^[Yy]$ ]]; then
        docker kill $(docker ps -q)
        docker ps
        docker ps -a
        docker rm $(docker ps -qa --no-trunc --filter "status=exited")
    fi
fi
