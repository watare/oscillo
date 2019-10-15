#!/bin/bash
#script editant pcap à partir de valeur de fin et debut
year=2019
startDate="$1"
startTime="$2"
startSecond="$3"

endDate="$4"
endTime="$5"
endSecond="$6"

#creation du fichier de la journee correspondante
echo "c'est parti" 
echo "$startDate"
filelist=$(find  -name "trace-$1*.zip" -exec sh -c 'unzip -jq -d tmp {}' ';')
for filename in ./tmp/*.pcap; do
	pcapfix -dn "$filename"
done

fixed=$(find -P "./" -name "fixed*.pcap")
if [ ! -z "$fixed" ]
then
	mergecap -w input"$year-$1 $2:$3 $year-$4 $5:$6".pcap $(find -P "./" -name "fixed*.pcap")
	#creation du fichier filtree sur la plage demandee
	echo "merge termine" 

	#penser a changer les droits du repertoir homeftpuser chmod o+rw /home/ftp/user
	editcap -A "$year-$1 $2:$3"  -B "$year-$4 $5:$6" input"$year-$1 $2:$3 $year-$4 $5:$6".pcap /root/ftpuser/"$year-$1 $2:$3 $year-$4 $5:$6".pcap  &&
	echo "edit termine" 
	#nettoyage
	rm *.pcap
	rm -Rf ./tmp &&
	echo "operation termine"
else
	echo "pas de fichier trouve"
fi
