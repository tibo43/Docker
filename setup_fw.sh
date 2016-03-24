#!/bin/sh

# Enable ip forwarding  
sysctl -w net.ipv4.ip_forward=1

# Affect variable with IP
var_ip=$(cat ip_tmp)

### rules of our iptables

## clear iptables rules
iptables -F
iptables -F -t nat

## default policies iptables
iptables -P FORWARD DROP
iptables -P INPUT DROP
iptables -P OUTPUT DROP

## forward packets between the docker and the outside
iptables -t filter -A FORWARD -p tcp -o eth0 -s 172.17.0.2 --sport 443 -j ACCEPT
iptables -t filter -A FORWARD -p tcp -o eth0 -s 172.17.0.2 --sport 80 -j ACCEPT
iptables -t filter -A FORWARD -p tcp -i eth0 -d 172.17.0.2 --dport 443 -j ACCEPT
iptables -t filter -A FORWARD -p tcp -i eth0 -d 172.17.0.2 --dport 80 -j ACCEPT

## redirection packets between ip guest and ip docker on ports 80 and  443
iptables -t nat -A PREROUTING -p tcp -d $var_ip --dport 80 -m state --state NEW,ESTABLISHED -j DNAT --to 172.17.0.2:80
iptables -t nat -A PREROUTING -p tcp -d $var_ip --dport 443 -m state --state NEW,ESTABLISHED -j DNAT --to 172.17.0.2:443
iptables -t nat -A POSTROUTING -s 172.17.0.2 -p tcp --sport 443 -m state --state ESTABLISHED -j SNAT --to $var_ip:443
