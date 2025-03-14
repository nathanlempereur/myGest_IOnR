#!/bin/bash

if [[ ! -f config.sh ]]; then
	bash install/install.sh
fi

if [[ $? -ne 0 ]]; then
	exit 0
fi


#import des configs et fonctions
source config.sh
source fonction.sh


#echo $serveur

echo "Bienvenu dans :"
afficheTitre "MyGest IOn ' R"
quitter=1
while [[ $quitter -ne 0 ]]
do
echo ""
afficheTitre "Menu principal"
echo ""
echo "Bienvenue $nom !"
echo "1) Gestion du parc"
echo "2) Outils réseau"
echo "0) Quitter"
echo -e "Veuillez choisir une option :"
read choix
case $choix in 
	1 )
		bash gestParc/menuParc.sh
		;;
	2 )
		bash outilsRx/menuOutils.sh
		;;
	0 )
		quitter=0
		afficheTitre "Au revoir"
		;;
	* )
		echo "Erreur dans la saisie"
		;;
esac
done
