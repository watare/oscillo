#!/bin/bash

mkdir /data_oscillo && chmod 777 /data_oscillo
mkdir /media/virtuelram && chmod 777 /media/virtuelram
echo tmpfs /media/virtuelram tmpfs defaults,size=1g 0 0 >> /etc/fstab && 
mount -a
