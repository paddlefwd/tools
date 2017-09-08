#!/bin/bash
# Delete all stopped containers
STOPPED_CONTAINERS=`docker ps -q -f status=exited | tr '\n' ' '`
if [[ -n ${STOPPED_CONTAINERS} ]] ; then
    docker rm ${STOPPED_CONTAINERS}
fi
# Delete all dangling (unused) images
DANGLING_IMAGES=`docker images -q -f dangling=true | tr '\n' ' '` 
if [[ -n ${DANGLING_IMAGES} ]] ; then
    docker rmi ${DANGLING_IMAGES}
fi
