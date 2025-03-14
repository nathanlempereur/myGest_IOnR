#!/bin/bash

source config.sh

mysql -u Gest -e "
use MyGest;
SELECT adIP
FROM Equipement;" --skip-column-names > IP.txt


echo "Test de l'ensemble des machines..."
cat IP.txt | while read IP
do 
    ping -c 1 $IP > /dev/null
    if [[ $? -eq 0 ]]; then
        echo -e "${valid}$IP${blanc}"
    else
        echo -e "${erreur}$IP${blanc}"
    fi
done
rm IP.txt
echo "[Appuyer sur entrer pour continuer]"
read
