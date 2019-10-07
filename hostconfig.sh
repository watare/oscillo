#!/bin/bash

mkdir /oscillo_data && chmod 777 /oscillo_data
mkdir /media/virtuelram && chmod 777 /media/virtuelram
echo tmpfs /media/virtuelram tmpfs defaults,size=1g 0 0 >> /etc/fstab && 
mount -a
