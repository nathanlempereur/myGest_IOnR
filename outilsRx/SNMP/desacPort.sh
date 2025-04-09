#!/bin/bash


echo "Saisir l'IP du switch : "
read IP

echo "Saisir le numéro de port"
read PORT_INDEX
    
    echo "Désactivation du port $PORT_INDEX sur l'adresse IP $IP..."
    
    if snmpset -v2c -c public "$IP" 1.3.6.1.2.1.2.2.1.7."$PORT_INDEX" i 2 > /dev/null 2>&1; then
        echo "Port $PORT_INDEX désactivé avec succès."
    else
        echo "Erreur lors de la désactivation du port $PORT_INDEX."
    fi
