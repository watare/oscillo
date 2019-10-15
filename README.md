# oscillo

# préparation de l'hôte

lancer la commande sudo /bin/bash hostconfig.sh

pour créer les dossier /oscillo_data et /media/virtuelram avec les bons droits 
le dossier virtuelram est un dossier tmpfs de 1g par defaut


# construction des images tcpdump et zipcomtrade

sudo /bin/bash dockerBuild.sh

# lancement des containeurs

sudo /bin/bash lancement_oscillo.sh

# stockage des fichiers

les fichiers capturés sont stockés temporairement (1 minute) dans le dossier mémoire /media/virtuelram
puis zippé et transférer dans le dossier /oscillo_data

# limitations actuelles

### une seule requette à la fois
### si aucun pcap ne correspond à la plage demandé un fichier vierge est quand même créé
