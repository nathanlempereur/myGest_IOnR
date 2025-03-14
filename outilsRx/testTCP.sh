#!/bin/bash

source config.sh
source fonction.sh

echo "Veuillez saisir une adresse IP :"
read IP
while ! validIP "$IP"; do
	echo "Veuillez saisir une adresse IP :"
	read IP
done
echo "Veuillez saisir un numéro de port TCP :"
read Port
echo "Envoie de la requête TCP ..."



(echo > /dev/tcp/$IP/$Port) > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "${valid}Le port TCP est ouvert sur l'adresse IP.${blanc}"
else
	echo -e "${erreur}Le port TCP n'est pas ouvert sur l'adresse IP.${blanc}"
fi

echo "[Appuyer sur entrer pour continuer]"
read
