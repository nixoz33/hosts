#!/bin/bash

while read line; do
    [[ "$line" =~ ^#.*$ ]] || [[ -z "$line" ]] && continue
    
    ip=$(echo $line | awk '{print $1}')
    host=$(echo $line | awk '{print $2}')
    
    [[ "$ip" == "127.0.0.1" ]] && continue
    
    actual_ip=$(nslookup $host | grep "Address: " | tail -n1 | awk '{print $2}')
    
    if [[ "$ip" != "$actual_ip" ]]; then
        echo "Bogus IP for $host in /etc/hosts!"
    fi
done < /etc/hosts
