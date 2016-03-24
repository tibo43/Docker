#!/bin/sh

#enable ip forwarding  
sysctl -w net.ipv4.ip_forward=1

#find IP of eth0
IP=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`;

#rules of our iptables
iptables -F
iptables -F -t nat
iptables -P FORWARD DROP
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -t filter -A FORWARD -s $IP -p tcp --sport 443 -m state --state ESTABLISHED,RELATED -j ACCEPT 
iptables -t filter -A FORWARD -d $IP -p tcp -m multiport -m multiport --dport 80,443 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A PREROUTING -d $IP -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j DNAT --to 172.17.0.2:80
iptables -t nat -A PREROUTING -d $IP -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j DNAT --to 172.17.0.2:443
iptables -t nat -A POSTROUTING -s 172.17.0.2 -p tcp --sport 443 -m state --state ESTABLISHED -j SNAT --to 192.168.43.240:443

