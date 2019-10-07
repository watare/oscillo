#!/bin/bash

#a saisir#####################################################################
carte_reseau='ens3' &&

#reinitialisation############################################################
echo initialisation efface les anciens conteneurs et le macvlan
tcpcontainer="$(docker ps -a| grep 'tcpdump')" &&
zipcontainer="$(docker ps -a|grep 'zipcomtrade')" &&
macvlannet="$(docker network ls | grep 'macvlan')" &&

[ ! -z "$tcpcontainer" ] && \
docker stop tcpdump && \
docker container rm tcpdump &&

[ ! -z "$zipcontainer" ] && \
docker stop zipcomtrade && \
docker container rm zipcomtrade &&

[ ! -z "$macvlannet" ] && \
docker network rm macvlan &&


#parametre reseau############################################################
echo configuraiton du macvlan
# ip="$(ip addr | grep -A 1 $carte_reseau| grep 'inet' | cut -d 'b' -f 1|cut -d 't' -f 2)" &&\
docker network create -d macvlan -o parent=$carte_reseau macvlan &&
#creation et lancement########################################################
#lancement des  containeurs
echo lancement des conteneurs


sudo docker run \
--restart always \
--name=tcpdump \
-v /media/virtuelram:/var/tmp \
--cap-add sys_nice \
--cap-add net_admin \
--net macvlan  \
tcpdump:latest &

echo tcpdump lance

sudo docker run  \
--restart always \
--name=zipcomtrade \
-v /media/virtuelram:/var/tmp \
-v /data_oscillo:/root/oscillo/data \
--net macvlan \
--cap-add sys_nice \
--cap-add net_admin \
zipcomtrade:latest & disown

echo zipcomtrade lance
#./dockerRun.sh
#& disown
