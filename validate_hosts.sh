#!/bin/bash

dns_verifier() {
  local host="$1"
  local expected_ip="$2"
  local dns_server="$3"

  local resolved_ip
  resolved_ip=$(dig "@$dns_server" "$host" +short | tail -n1 | tr -d '[:space:]')

  if [ "$resolved_ip" = "$expected_ip" ]; then
    echo "[SUCCES] $host se potriveste cu IP-ul $expected_ip pe serverul DNS $dns_server"
    return 0
  else
    echo "[ESEC] $host rezolva la IP-ul '$resolved_ip' (asteptat: $expected_ip) folosind $dns_server"
    return 1
  fi
}
DNS_SERVER="8.8.8.8"
echo "Verificare folosind DNS: $DNS_SERVER"

while read -r ip hostname rest; do
  [[ -z "$ip" || "$ip" =~ ^# ]] && continue

  if [ -n "$ip" ] && [ -n "$hostname" ]; then
    dns_verifier "$hostname" "$ip" "$DNS_SERVER"
  fi
done < /etc/hosts
echo "Andrei Paun"
