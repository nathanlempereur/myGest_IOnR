#!/bin/bash

source config.sh
source fonction.sh

read -p "> Donner l'IP de la machine : " IP
while ! validIP "$IP"; do
    read -p "> Donner l'IP de la machine : " IP
done
read -p "> Donner l'identifiant de connexion : " LOGIN
read -p "> Donner le n° de port : " PORT

ssh -p $PORT $LOGIN@$IP