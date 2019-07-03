#!/bin/bash

#constuction de l image
docker build -t zipcomtrade:latest .

#lancement du containeur

sudo docker run  --name=zipcomtrade -v /media/virtuelram:/var/tmp -v /data_oscillo:/root/oscillo/data --cap-add sys_nice --cap-add net_admin -it zipcomtrade:latest
#sudo docker exec  --mount type=tmpfs,destination=/var/tmp --cap-add sys_nice --cap-add net_admin -it tcpdump:latest
