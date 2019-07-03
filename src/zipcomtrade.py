
import sys
import time
import glob, os
import os.path
import zipfile

homedir = os.path.expanduser("~")
chemindesfichiers = homedir+"/oscillo/data"

#initialisation
#creation du premier repertoire qui stockera les pcap
directoryByHourReference = time.strftime("%m-%d-%H")
nomCheminDataParHeure = chemindesfichiers+"/"+directoryByHourReference
print(nomCheminDataParHeure)
try:
    os.mkdir(nomCheminDataParHeure)
except :
    pass

#programme
while True:
    directoryByHour = time.strftime("%m-%d-%H")

    if directoryByHour != directoryByHourReference:
        nomCheminDataParHeure = chemindesfichiers+"/"+directoryByHour
        try:
            os.mkdir(nomCheminDataParHeure)
        except :
            sys.exit()

    tempsDernierFichier = int(time.strftime("%M"))-1

    if tempsDernierFichier < 10:
        tempsDernierFichier = "0"+str(tempsDernierFichier)
    #le fichier en cours utilise par tcpdump ne doit pas etre zipe et efface
    nomFichierPrededent = "trace-"+time.strftime("%m-%d-%H")+"-"+str(tempsDernierFichier)+".pcap"
    nomFichierCourant = "trace-"+time.strftime("%m-%d-%H-%M")+".pcap"

    for file in glob.glob("/var/tmp/*.pcap"):
        if (os.path.basename(file) !=nomFichierCourant and os.path.basename(file) !=nomFichierPrededent):
            zip_file = zipfile.ZipFile(nomCheminDataParHeure+"/"+os.path.basename(file)+'.zip','w')
            zip_file.write(file, compress_type=zipfile.ZIP_DEFLATED)
            zip_file.close()
            os.remove(file)

    time.sleep(30)
