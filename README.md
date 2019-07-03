# oscillo

#sur l'hôte
##créer un répertoire /oscillo_data
chmod 777 /oscillo_data

##créer un disque dur ram de façon permanente
##ajouter la ligne suivante au fichier /etc/fstab
tmpfs /media/virtuelram tmpfs defaults,size=1g 0 0

#construction des conteneurs

script dockerBuild*
s'assurer d'utiliser le bon Dockerfile (tcpdump ou zip)
