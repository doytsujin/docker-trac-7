#!/bin/bash

if [ -f trac_docker.id ]
  then
    CID=`cat trac_docker.id`
    docker start $CID
  else
    echo "no trac_docker.id file found... is really running?"
fi


