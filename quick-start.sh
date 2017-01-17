#!/bin/bash

docker build -t mytrac .

if [ ! -f trac_docker.id ]
  then
    CID=`cat trac_docker.id`
    docker stop `docker ps --filter id=$CID -q`
  else
    #docker stop `docker ps --filter status=running -q`
    docker stop `docker ps --filter network=bridge -q`
fi

rm -f trac_docker.id
docker run --cidfile trac_docker.id   -i -p 80:80 -t mytrac

