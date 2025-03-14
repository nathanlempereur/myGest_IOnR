#!/bin/bash


quitter=1
while [[ $quitter -ne 0 ]]
do
echo "Que souhaitez vous générer :"
echo "1) Toutes les infos"
echo "2) Toutes les IP des machines"
echo "3) Toutes les Adresses MAC des machines"
echo "4) Toutes les Adresses MAC et IP des machines"
echo "0) Quitter"
echo -e "Veuillez choisir une option :"
read choix
case $choix in 
	1 )
        echo "Veuillez choisir le nom du ficher txt :"
        read fichier
		mysql -u Gest -e "
        USE MyGest;
        SELECT TypeE.libelle as Type, Equipement.id as Id, Equipement.nom as Nom, Equipement.adMAC as Adresse_MAC, Equipement.adIP as Adresse_IP, Equipement.CIDR as Masque
        FROM TypeE, Equipement
        WHERE TypeE.id = Equipement.idT
        ORDER BY Type ASC;" > ~/$fichier.txt
        echo "Le fichier $fichier.txt à été générer."
        echo "[Appuyer sur entrer pour continuer]"
        read
		;;
	2 )
        echo "Veuillez choisir le nom du ficher txt :"
        read fichier
		mysql -u Gest -e "
        USE MyGest;
        SELECT nom as Nom, adIP as Adresse_IP, CIDR as Masque
        FROM Equipement
        ORDER BY nom ASC;" > ~/$fichier.txt
        echo "Le fichier $fichier.txt à été générer."
        echo "[Appuyer sur entrer pour continuer]"
        read
		;;
	3 )
        echo "Veuillez choisir le nom du ficher txt :"
        read fichier
		mysql -u Gest -e "
        USE MyGest;
        SELECT nom as Nom, adMAC as Adresse_MAC
        FROM Equipement
        ORDER BY nom ASC;" > ~/$fichier.txt
        echo "Le fichier $fichier.txt à été générer."
        echo "[Appuyer sur entrer pour continuer]"
        read
		;;
	4 )
        echo "Veuillez choisir le nom du ficher txt :"
        read fichier
		mysql -u Gest -e "
        USE MyGest;
        SELECT nom as Nom, adIP Adresse_IP, CIDR as Masque, adMAC as Adresse_MAC
        FROM Equipement
        ORDER BY nom ASC;" > ~/$fichier.txt
        echo "Le fichier $fichier.txt à été générer."
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
