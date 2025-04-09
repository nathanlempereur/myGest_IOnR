#!/bin/bash

source config.sh
source fonction.sh

echo "Veuillez saisir l'adresse IP :"
read IP
while ! validIP "$IP"; do
    echo "Veuillez saisir une adresse IP :"
    read IP
done
echo "Envoie de la requête SNMP ...

*********************************
         MAC	| PORT | STATUS *
*********************************"


if ! command -v snmpwalk &> /dev/null; then
    echo "Erreur : snmpwalk n'est pas installé. Installez-le avant d'exécuter ce script."
    exit 1
fi

snmpwalk -v2c -c public "$IP" 1.3.6.1.2.1.17.4.3.1.2 | \
    awk -F': ' '$2 > 1 {print $1}' | \
    awk -F. '{for(i=NF-5;i<=NF;i++) printf "%02X%s", $i, (i==NF ? "\n" : ":")}' > MAC.txt

# Extraction des numéros de ports associés aux adresses MAC et stockage dans PORT.txt
snmpwalk -v2c -c public "$IP" 1.3.6.1.2.1.17.4.3.1.2 | \
    awk -F': ' '$2 > 1 {split($1, a, "."); mac=""; for(i=NF-5;i<=NF;i++) mac=sprintf("%s%d%s", mac, a[i], (i==NF ? "" : ".")); print mac, $2}' | \
    awk '{print $NF}' > PORT.txt

# Récupération des statuts des ports et stockage dans UP.txt
snmpwalk -v2c -c public "$IP" 1.3.6.1.2.1.2.2.1.8 | \
    awk -F'.' '/iso.3.6.1.2.1.2.2.1.8./ {split($0, a, "="); print a[1], a[2]}' | \
    awk '{print $NF}' > UP.txt

# Chargement des ports et de leurs statuts dans des tableaux
mapfile -t PORTS < PORT.txt
mapfile -t UP_STATUS < UP.txt

# Nombre total de ports trouvés
port_count=${#PORTS[@]}

# Initialisation du compteur pour les ports
index=0

# Associer les adresses MAC aux ports et leur état UP/DOWN
while read -r MAC; do
    if [ $index -lt $port_count ]; then
        PORT=${PORTS[index]}
        STATUS=${UP_STATUS[index]}
        
        # Conversion de l'état numérique en texte lisible
        case $STATUS in
            1) STATUS="UP" ;;
            2) STATUS="DOWN" ;;
            *) STATUS="UNKNOWN" ;;
        esac
        
        echo "$MAC | $PORT | $STATUS
****************************"
        ((index++))
    else
        echo "$MAC No available port"
    fi
done < MAC.txt

rm MAC.txt PORT.txt UP.txt

echo "
[Appuyer sur entrer pour continuer]"
read
