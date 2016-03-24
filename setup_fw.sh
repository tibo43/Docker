#!/bin/sh

#enable ip forwarding  
sysctl -w net.ipv4.ip_forward=1

#find IP of eth0
#ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}' > tmp_ip
#IP=$(cat tmp_ip)
#rm tmp_ip
#echo $IP
ifconfig > conf_ip_tmp
sed -e '/eth0/,/inet/!d' conf_ip_tmp > iface_ip_tmp
rm conf_ip_tmp
awk -F'[ :]+' '/inet adr/{print $4}' iface_ip_tmp > ip_tmp
rm iface_ip_tmp
var_ip=$(cat ip_tmp)
echo "ip source is now $var_ip"


#rules of our iptables
iptables -F
iptables -F -t nat

iptables -P FORWARD DROP
iptables -P INPUT DROP
iptables -P OUTPUT DROP


iptables -t filter -A FORWARD -p tcp -o eth0 -s 172.17.0.2 --sport 443 -j ACCEPT
iptables -t filter -A FORWARD -p tcp -o eth0 -s 172.17.0.2 --sport 80 -j ACCEPT
iptables -t filter -A FORWARD -p tcp -i eth0 -d 172.17.0.2 --dport 443 -j ACCEPT
iptables -t filter -A FORWARD -p tcp -i eth0 -d 172.17.0.2 --dport 80 -j ACCEPT


iptables -t nat -A PREROUTING -p tcp -d $var_ip --dport 80 -m state --state NEW,ESTABLISHED -j DNAT --to 172.17.0.2:80
iptables -t nat -A PREROUTING -p tcp -d $var_ip --dport 443 -m state --state NEW,ESTABLISHED -j DNAT --to 172.17.0.2:443
iptables -t nat -A POSTROUTING -s 172.17.0.2 -p tcp --sport 443 -m state --state ESTABLISHED -j SNAT --to $var_ip:443
