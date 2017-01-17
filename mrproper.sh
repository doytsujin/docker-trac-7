#!/bin/bash

# clean all images and containers
docker rm `docker ps -aq` 
docker rmi `docker images -q` 

# build the image from scratch
docker build -t mytrac .
