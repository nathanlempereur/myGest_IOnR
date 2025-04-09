#!/bin/bash

user=$(whoami)
if [[ $user != 'root' ]]; then
    echo "Vous devez être root pour continuer l'installation."
    exit 2
fi

echo "
*************************************************************************************
*************************************************************************************
********************************Test de la config reseau sur www.google.fr***********
*************************************************************************************
*************************************************************************************
"
ping -c 3 www.google.fr > /dev/null

if [[ $? -eq 0 ]]; then
    echo "
*************************************************************************************
********************************Config reseau OK !***********************************
*************************************************************************************
"
else
    echo "
*************************************************************************************
********************************Erreur dans la config reseau*************************
*************************************************************************************
"
    exit 1
fi

sleep 2


echo "
********************************************************************
**********************Installation de myGest_IOnR*******************
********************************************************************

"

read -p "Comment voulez-vous vous appeler ? : " name
read -p "Installation sur client: 0; server: 1 : " mode
while [ $mode -ne 0 -a $mode -ne 1 ]; do
    echo "Saisie incorrecte."
    read -p "Installation sur client: 0; server: 1 : " mode
done

read -p "Activer le mode d'altonien ? (Oui: 1; Non: 0) : " couleur
while [ $couleur -ne 0 -a $couleur -ne 1 ]; do
    echo "Saisie incorrecte."
    read -p "Activer le mode d'altonien ? (Oui: 1; Non: 0) : " couleur
done


echo "
#!/bin/bash

#permet de determiner si programme sur un serveur (1) ou une machine (0). Utile pour IHM
serveur=$mode
#permet d'afficher le nom de l'utilisateur
nom="$name"" > config.sh


if [[ $couleur -eq 0 ]]; then
    echo "
#Couleur adapter en fonction du mode daltonien ou non.
valid='\e[32m'
erreur='\e[31m'
blanc='\e[0m'" >> config.sh
else
    echo "
#Couleur adapter en fonction du mode daltonien ou non.
valid='\e[33m'
erreur='\e[36m'
blanc='\e[0m'" >> config.sh
fi



echo "
********************************************************************
**********************Installation des Paquets**********************
********************************************************************

"
apt update > /dev/null 

if [[ $mode -eq 0 ]]; then
    apt install -y lolcat mariadb-server figlet snmp > /dev/null 2>&1
else
    apt install -y mariadb-server figlet snmp > /dev/null 2>&1
fi

if [[ $? -eq 0 ]]; then
    echo "
********************************
Installation des paquets : OK !*
********************************"
    sleep 2
else
    echo "
************************************
Installation des paquets : Erreur..*
************************************"
    exit 2
fi


echo "
********************************************************************
**********************Installation de la BDD************************
********************************************************************

"

mysql -e "
CREATE DATABASE MyGest;
CREATE USER 'Gest'@'localhost';
GRANT ALL PRIVILEGES ON MyGest.* TO 'Gest'@'localhost';
FLUSH PRIVILEGES;
" > /dev/null 2>&1

mysql -u Gest MyGest < install/myGestIOnR.sql 

sleep 1

echo "
********************************************************************
**********************Installation fini.****************************
********************************************************************

"
sleep 1
echo "[Appuyer sur entrer pour continuer]"
read
