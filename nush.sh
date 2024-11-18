#!/bin/bash

# Funcția care verifică asocierea IP-ului cu numele hostului folosind un server DNS
verifica_ip_host() {
    local host=$1
    local ip=$2
    local dns_server=$3

    # Verifică asocierea IP-ului cu numele hostului pe serverul DNS
    nslookup $host $dns_server | grep -q "$ip"
    if [ $? -eq 0 ]; then
        echo "Asocierea $ip cu hostul $host este validă pe serverul DNS $dns_server."
    else
        echo "Asocierea $ip cu hostul $host nu este validă pe serverul DNS $dns_server."
    fi
}

# Citește fiecare linie din /etc/hosts
while IFS= read -r line; do
    # Extrage IP-ul și numele hostului
    ip=$(echo $line | awk '{print $1}')
    host=$(echo $line | awk '{print $2}')

    # Verifică asocierea folosind funcția shell
    verifica_ip_host $host $ip "8.8.8.8"  # Exemplu de server DNS (Google DNS)
done < /etc/hosts
Numele studentului A este: AlexFolea22
