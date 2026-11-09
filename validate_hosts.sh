#!/bin/bash

echo "Verificare adrese IP din /etc/hosts..."

while read -r ip hostname; do
  [[ -z "$ip" || "$ip" =~ ^# ]] && continue
  echo "Gasit: Hostname: $hostname -> IP: $ip"
done < /etc/hosts
