#!/bin/bash

#a saisir#####################################################################
carte_reseau='ens3' &&

#reinitialisation############################################################
echo initialisation efface les anciens conteneurs et le macvlan
tcpcontainer="$(docker ps -a| grep 'tcpdump')" &&
zipcontainer="$(docker ps -a|grep 'zipcomtrade')" &&
macvlannet="$(docker network ls | grep 'macvlan')" &&
nodeservercontainer="$(docker ps -a|grep 'nodeserver')" &&
oscilloappcontainer="$(docker ps -a|grep 'oscillo-app')" &&

echo "suppression $tcpcontainer"
[ ! -z "$tcpcontainer" ] && \
docker stop tcpdump && \
docker container rm tcpdump 

echo "suppression $nodeservercontainer"
[ ! -z "$nodeservercontainer" ] && \
docker stop nodeserver && \
docker container rm nodeserver

echo "suppression $zipcontainer"
[ ! -z "$zipcontainer" ] && \
docker stop zipcomtrade && \
docker container rm zipcomtrade 

echo "suppression $oscilloappcontainer"

[ ! -z "$oscilloappcontainer" ] && \
docker stop oscillo-app && \
docker container rm oscillo-app 

echo "suppression $macvlannet"

[ ! -z "$macvlannet" ] && \
docker network rm macvlan 


#parametre reseau############################################################
echo configuraiton du macvlan &&
ip="$(ip addr | grep -A 1 $carte_reseau|sed 's: ::g' | grep 'inet' | cut -d 'b' -f 1|cut -d 't' -f 2)" &&
echo $ip
#docker network create -d macvlan --subnet=$ip -o parent=$carte_reseau macvlan &&
docker network create -d macvlan --subnet=$ip  -o parent=$carte_reseau macvlan &&
echo "$carte_reseau"
#creation et lancement########################################################
#lancement des  containeurs
echo lancement des conteneurs

# nodeserver
sudo docker run \
--restart always \
--name=nodeserver \
-v /oscillo_data:/root/data \
-v /home/ftpuser:/root/ftp \
--cap-add sys_nice \
--cap-add net_admin \
--net macvlan  \
nodeserver:latest &

echo "nodeserver lance"

#dockerbuild

sudo docker run \
--name=oscillo-app \
--net macvlan \
oscillo-app:latest &


echo "oscillo-app lance"

sudo docker run \
--restart always \
--name=tcpdump \
-v /media/virtuelram:/var/tmp \
--cap-add sys_nice \
--cap-add net_admin \
--net macvlan  \
tcpdump:latest &

echo "tcpdump lance"

sudo docker run  \
--restart always \
--name=zipcomtrade \
-v /media/virtuelram:/var/tmp \
-v /data_oscillo:/root/oscillo/data \
--net macvlan \
--cap-add sys_nice \
--cap-add net_admin \
zipcomtrade:latest & disown

echo "zipcomtrade lance"
#./dockerRun.sh
#& disown
