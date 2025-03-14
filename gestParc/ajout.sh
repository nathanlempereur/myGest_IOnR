#!/bin/bash

source fonction.sh

echo "Veuillez saisir les informations suivantes :"
read -p "> Nom : " Nom
read -p "> Adresse MAC : " MAC
while ! validMAC "$MAC"; do
    echo "Erreur dans la saisi de l'adresse MAC..."
    read -p "> Adresse MAC : " MAC
done
read -p "> Adresse IP : " IP
while ! validIP "$IP"; do
    echo "Erreur dans la saisi de l'IP..."
    read -p "> Adresse IP : " IP
done
read -p "> Masque (CIDR) : " Masque
read -p "> Type (1: machine; 2: switch; 3: serveur; 4: routeur) : " Type

echo "Récapitulatif de la requete :"
echo "> INSERT INTO Equipement (nom, adMAC, adIP, CIDR, idT) VALUES ('$Nom','$MAC','$IP','$Masque','$Type');"
read -p "Confirmer l'insertion (o/n) : " confirmation

if [[ $confirmation == "o" ]]; then
    mysql -u Gest -e "
    USE MyGest;
    INSERT INTO Equipement (nom, adMAC, adIP, CIDR, idT)
    VALUES ('$Nom','$MAC','$IP','$Masque','$Type');"

    if [[ $? -eq 0 ]]; then
        echo "Les saisies ont été intégrées à la base de données"

        mysql -u Gest -e "
        USE MyGest;
        SELECT TypeE.libelle as Type, Equipement.id as Id, Equipement.nom as Nom, Equipement.adMAC as Adresse_MAC, Equipement.adIP as Adresse_IP, Equipement.CIDR as Masque
        FROM TypeE, Equipement
        WHERE TypeE.id = Equipement.idT
        AND Equipement.idT = $Type
        AND Equipement.nom LIKE '$Nom';"
    else
        echo "Erreur dans l'intégration des informations dans la base de données"
    fi
    echo "[Appuyer sur entrer pour continuer]"
    read
fi
