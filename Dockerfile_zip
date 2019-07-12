FROM ubuntu
#ajout du script a l image docker
ADD ./src/zipcomtrade.py /root
ADD ./venv36_requirement.txt /root

WORKDIR /root

#changement des droits
RUN chmod +x zipcomtrade.py
RUN apt-get update
RUN apt-get install -y python3.6
RUN apt install -y python3-pip
RUN pip3 install -r venv36_requirement.txt

#exectution de la fonction
CMD /usr/bin/python3 zipcomtrade.py
