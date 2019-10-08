#!/bin/bash

#constuction des  images
docker build -f Dockerfile_zip -t zipcomtrade:latest .
docker build -f Dockerfile_tcp -t tcpdump:latest .
docker build -f Dockerfile_node -t nodeserver:latest .
docker build -f Dockerfile_angular -t oscillo-app:latest .
#sudo docker exec  --mount type=tmpfs,destination=/var/tmp --cap-add sys_nice --cap-add net_admin -it tcpdump:latest
