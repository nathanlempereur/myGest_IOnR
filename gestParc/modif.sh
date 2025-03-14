#/bin/bash

source fonction.sh

read -p "Donner l'id de l'équipement à modifier : " id

mysql -u Gest -e "
USE MyGest;
SELECT *
FROM Equipement
WHERE id = $id;"

read -p "Continuer ? (o/n) : " continuer
if [[ $continuer == "o" ]]; then
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
    echo "> UPDATE Equipement set nom='$Nom', adMAC='$MAC', adIP='$IP', CIDR='$Masque', idT='$Type' WHERE id=$id;"

    read -p "Confirmer la modification (o/n) : " confirmation
    if [[ $confirmation == "o" ]]; then
        mysql -u Gest -e "
        USE MyGest;
        UPDATE Equipement 
        set nom='$Nom', adMAC='$MAC', adIP='$IP', CIDR='$Masque', idT='$Type' 
        WHERE id=$id;"

        if [[ $? -eq 0 ]]; then
            echo "Les saisies ont été modifiées dans la base de données"
        
            mysql -u Gest -e "
            USE MyGest;
            SELECT *
            FROM Equipement
            WHERE id = $id;"
            echo "Voici l'équipement modifier."
        else
            echo "Erreur dans la modification des informations dans la base de données"
        fi
        echo "[Appuyer sur entrer pour continuer]"
        read
    fi
fi
