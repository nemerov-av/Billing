#!/bin/bash

LAN=ens19
LAN3=ens21
WAN=ens18
WAN2=ens20
LAN1=vlan5
LAN2=vlan7
IP=$(/sbin/ip -o -4 addr list ens20 | awk '{print $4}' | cut -d/ -f1)

iptables -F OUTPUT
iptables -F INPUT
iptables -F FORWARD
iptables -t nat -F
iptables -t mangle -F
iptables -I INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 2233 -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -P INPUT DROP

iptables -I FORWARD -o ${LAN} -j ACCEPT
iptables -I FORWARD -o ${LAN1} -j ACCEPT
iptables -I FORWARD -o ${LAN2} -j ACCEPT
iptables -I FORWARD -o ${LAN3} -j ACCEPT
iptables -I FORWARD -o ${WAN2} -j ACCEPT
# передача данных между контейнерами для мониторинга
iptables -I FORWARD -o br-239ac3590bc2 -j ACCEPT 

iptables -I FORWARD -m set --match-set acces src -j ACCEPT
iptables -I FORWARD -m set --match-set acces dst -j ACCEPT

iptables -P FORWARD DROP
iptables -t mangle -A POSTROUTING -o ${LAN} -j SET --map-set 70mbit dst --map-prio
iptables -t mangle -A POSTROUTING -o ${LAN} -j SET --map-set 70mbit src --map-prio
iptables -t mangle -A POSTROUTING -o ${LAN1} -j SET --map-set 70mbit dst --map-prio
iptables -t mangle -A POSTROUTING -o ${LAN1} -j SET --map-set 70mbit src --map-prio
iptables -t mangle -A POSTROUTING -o ${LAN2} -j SET --map-set 70mbit dst --map-prio
iptables -t mangle -A POSTROUTING -o ${LAN2} -j SET --map-set 70mbit src --map-prio


iptables -t mangle -A FORWARD -i ${WAN} -j ACCEPT
iptables -t mangle -A FORWARD -o ${WAN} -j ACCEPT
iptables -t nat -A POSTROUTING -o ${WAN} -j MASQUERADE
iptables -t nat -A POSTROUTING -o ${WAN2} -j MASQUERADE

#проброс портов на архив камер
#iptables -t nat -A PREROUTING -p tcp -d ${IP} --dport 2222 -j DNAT --to-destination 192.168.88.3:2222

#проброс портов на vpnserver
#iptables -t nat -A PREROUTING -p tcp -d ${IP} --dport 31002 -j DNAT --to-destination 192.168.100.2:22

#проброс портов на сервер вин 7
#iptables -t nat -A PREROUTING -p tcp -d ${IP} --dport 3307 -j DNAT --to-destination 192.168.88.7:3389

#мониторинг
#iptables -I INPUT -p tcp --dport 3000 -j ACCEPT
#iptables -I INPUT -p tcp --dport 9100 -j ACCEPT
#iptables -t nat -A PREROUTING -p tcp -d ${IP} --dport 9101 -j DNAT --to-destination 192.168.4.77:9100
#iptables -t nat -A POSTROUTING -p tcp --sport 9100 --dst 192.168.4.77 -j SNAT --to-source ${IP}:9101

