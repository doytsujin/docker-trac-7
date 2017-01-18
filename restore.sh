#!/bin/bash

CID=`cat trac_docker.id`

# pause the container
echo "Pausing container"
docker stop $CID

# copy some files BACK
echo "Creating a safe copy inside container"
docker cp $CID:/var/trac/db/trac.db .tmp
docker cp .tmp $CID:/var/trac/db/trac.db.safe 

docker cp $CID:/var/trac/conf/trac.ini .tmp
docker cp .tmp $CID:/var/trac/conf/trac.ini.safe 

rm .tmp


echo "Restoring files"
docker cp backup/trac.db $CID:/var/trac/db/trac.db 
docker cp backup/trac.ini $CID:/var/trac/conf/trac.ini 

# resume container
echo "Resuming container"
docker start $CID

