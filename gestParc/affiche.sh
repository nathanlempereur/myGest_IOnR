#!/bin/bash


quitter=1
while [[ $quitter -ne 0 ]]
do
echo "Que souhaitez vous consulter :"
echo "1) Toutes les informations"
echo "2) Seulement les machines"
echo "3) Seulement les serveurs"
echo "4) Seulement les Switchs"
echo "0) Quitter"
echo -e "Veuillez choisir une option :"
read choix
case $choix in 
	1 )
		mysql -u Gest -e "
        USE MyGest;
        SELECT TypeE.libelle as Type, Equipement.id as Id, Equipement.nom as Nom, Equipement.adMAC as Adresse_MAC, Equipement.adIP as Adresse_IP, Equipement.CIDR as Masque
        FROM TypeE, Equipement
        WHERE TypeE.id = Equipement.idT
        ORDER BY Type ASC;"
        echo "[Appuyer sur entrer pour continuer]"
        read
		;;
	2 )
		mysql -u Gest -e "
        USE MyGest;
        SELECT TypeE.libelle as Type, Equipement.id as Id, Equipement.nom as Nom, Equipement.adMAC as Adresse_MAC, Equipement.adIP as Adresse_IP, Equipement.CIDR as Masque
        FROM TypeE, Equipement
        WHERE TypeE.id = Equipement.idT AND TypeE.libelle LIKE 'Machine'
        ORDER BY Nom ASC;"
        echo "[Appuyer sur entrer pour continuer]"
        read
		;;
	3 )
		mysql -u Gest -e "
        USE MyGest;
        SELECT TypeE.libelle as Type, Equipement.id as Id, Equipement.nom as Nom, Equipement.adMAC as Adresse_MAC, Equipement.adIP as Adresse_IP, Equipement.CIDR as Masque
        FROM TypeE, Equipement
        WHERE TypeE.id = Equipement.idT AND TypeE.libelle LIKE 'Serveur'
        ORDER BY Nom ASC;"
        echo "[Appuyer sur entrer pour continuer]"
        read
		;;
	4 )
		mysql -u Gest -e "
        USE MyGest;
        SELECT TypeE.libelle as Type, Equipement.id as Id, Equipement.nom as Nom, Equipement.adMAC as Adresse_MAC, Equipement.adIP as Adresse_IP, Equipement.CIDR as Masque
        FROM TypeE, Equipement
        WHERE TypeE.id = Equipement.idT AND TypeE.libelle LIKE 'Switch'
        ORDER BY Nom ASC;"
        echo "[Appuyer sur entrer pour continuer]"
        read
		;;
	0 )
		quitter=0
		;;
	* )
		echo "Erreur dans la saisie"
        echo "[Appuyer sur entrer pour continuer]"
        read
		;;
esac
done
