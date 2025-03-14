#!/bin/bash

echo "Création du backup de la BDD"

date_sauvegarde=$(date +"%d-%m-%Y_%H-%M-%S")
nom="myGestIOnR"
dossier="${nom}_${date_sauvegarde}"

mysqldump -u Gest MyGest > ~/$dossier.sql

echo "Backup terminer."
echo "[Appuyer sur entrer pour continuer]"
read
