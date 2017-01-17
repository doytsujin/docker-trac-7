#!/bin/bash

docker build -t mytrac .

source pause.sh

rm -f trac_docker.id
docker run --cidfile trac_docker.id -d -p 80:80 -t mytrac

