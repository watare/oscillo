#!/bin/bash

#constuction de l image
docker build -t tcpdump:latest .

#lancement du containeur

sudo docker run  --name=tcpdump -v /media/virtuelram:/var/tmp --cap-add sys_nice --cap-add net_admin -it tcpdump:latest
#sudo docker exec  --mount type=tmpfs,destination=/var/tmp --cap-add sys_nice --cap-add net_admin -it tcpdump:latest
