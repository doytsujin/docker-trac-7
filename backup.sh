#!/bin/bash

CID=`cat trac_docker.id`

# pause the container
echo "Pausing container"
docker stop $CID

# copy some files
echo "Coping files"
mkdir -p backup/
docker cp $CID:/var/trac/db/trac.db backup/
docker cp $CID:/var/trac/conf/trac.ini backup/

# resume container
echo "Resuming container"
docker start $CID

