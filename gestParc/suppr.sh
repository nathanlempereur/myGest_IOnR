#!/bin/bash

read -p "Donner l'id de l'équipement à supprimer : " id

mysql -u Gest -e "
USE MyGest;
SELECT *
FROM Equipement
WHERE id = $id;"

read -p "Confirmer la suppression (o/n) : " confirmation
if [[ $confirmation == "o" ]]; then
    mysql -u Gest -e "
    USE MyGest;
    DELETE FROM Equipement 
    WHERE id = $id;"

    if [[ $? -eq 0 ]]; then
echo "Les saisies ont été supprimer de la base de données"
    else
echo "Erreur dans la suppression des informations dans la base de données"
    fi
    echo "[Appuyer sur entrer pour continuer]"
    read
fi
