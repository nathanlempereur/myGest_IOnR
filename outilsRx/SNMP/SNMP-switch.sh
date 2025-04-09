#!/bin/bash

source config.sh
source fonction.sh

echo "Veuillez saisir l'adresse IP :"
read IP
while ! validIP "$IP"; do
    echo "Veuillez saisir une adresse IP :"
    read IP
done

echo "Veuillez saisir le port WAN :"
read WAN
echo "Envoie de la requête SNMP ...

*********************************
         MAC	| PORT | STATUS *
*********************************"

if ! command -v snmpwalk &> /dev/null; then
    echo "Erreur : snmpwalk n'est pas installé. Installez-le avant d'exécuter ce script."
    exit 1
fi

# Extraction des adresses MAC (en excluant le port WAN et le port 0)
snmpwalk -v2c -c public "$IP" 1.3.6.1.2.1.17.4.3.1.2 | \
    awk -F': ' -v wan="$WAN" '
        {
            gsub(/ /,"",$2);
            if ($2 != wan && $2 != "0") print $1
        }' | \
    awk -F. '{for(i=NF-5;i<=NF;i++) printf "%02X%s", $i, (i==NF ? "\n" : ":")}' > MAC.txt

# Extraction des ports associés (toujours en excluant le port WAN et le port 0)
snmpwalk -v2c -c public "$IP" 1.3.6.1.2.1.17.4.3.1.2 | \
    awk -F': ' -v wan="$WAN" '
        {
            gsub(/ /,"",$2);
            if ($2 != wan && $2 != "0") {
                split($1, a, ".");
                mac="";
                for(i=NF-5;i<=NF;i++) mac=sprintf("%s%d%s", mac, a[i], (i==NF ? "" : "."));
                print mac, $2
            }
        }' | awk '{print $NF}' > PORT.txt

# Récupération des statuts (1 = UP, 2 = DOWN)
snmpwalk -v2c -c public "$IP" 1.3.6.1.2.1.2.2.1.8 | \
    awk -F'.' '/iso.3.6.1.2.1.2.2.1.8./ {
        split($0, a, "=");
        print a[1], a[2]
    }' | awk '{print $NF}' > UP.txt

# Lecture des ports et statuts dans des tableaux
mapfile -t PORTS < PORT.txt
mapfile -t UP_STATUS < UP.txt

port_count=${#PORTS[@]}
index=0

# Affichage des résultats
while read -r MAC; do
    if [ $index -lt $port_count ]; then
        PORT=${PORTS[index]}
        STATUS=${UP_STATUS[index]}
        
        case $STATUS in
            1) STATUS="UP" ;;
            2) STATUS="DOWN" ;;
            *) STATUS="UNKNOWN" ;;
        esac

        echo "$MAC | $PORT | $STATUS"
        echo "****************************"
        ((index++))
    else
        echo "$MAC | No available port"
    fi
done < MAC.txt

# Nettoyage
rm -f MAC.txt PORT.txt UP.txt

echo "
[Appuyer sur entrer pour continuer]"
read
