#!/bin/bash

#import des configs et fonctions
source config.sh
source fonction.sh


afficheTitre 'Outils SNMP'
quitter=1
while [[ $quitter -ne 0 ]]
do
echo -e "\nMenu :"
echo "1) Table MAC-PORT"
echo "2) Desactiver un port"
echo "3) Activer un port"
echo "0) Retour au outils reseau"
echo -e "Veuillez choisir une option :"
read choix
case $choix in 
	1 )
		bash outilsRx/SNMP/SNMP-switch.sh
		;;
	2 )
		bash outilsRx/SNMP/desacPort.sh
		;;
	3 )
		bash outilsRx/SNMP/activePort.sh
		;;
	0 )
		quitter=0
		;;
	* )
		echo "Erreur dans la saisie"
		;;
esac
done
