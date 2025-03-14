#!/bin/bash

source config.sh
source fonction.sh

echo "Veuillez saisir une adresse IP :"
read IP
while ! validIP "$IP"; do
    echo "Veuillez saisir une adresse IP :"
    read IP
done
echo "Envoie de la requête ICMP ..."


ping -c 3 $IP > /dev/null
if [[ $? -eq 0 ]]; then
    echo -e "${valid}L'adresse IP répond aux pings.${blanc}"
else
    echo -e "${erreur}L'adresse ne répond pas aux pings.${blanc}"
fi

echo "[Appuyer sur entrer pour continuer]"
read
