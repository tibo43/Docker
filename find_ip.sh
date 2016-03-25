#!/bin/sh

## You need to type your interface
## change the interface in the variable

## write the interface
INTERFACE='eth0'

## find IP adress
ifconfig > conf_ip_tmp
sed -e '/'$INTERFACE'/,/inet/!d' conf_ip_tmp > iface_ip_tmp
rm conf_ip_tmp
awk -F'[ :]+' '/inet adr/{print $4}' iface_ip_tmp > ip_tmp
rm iface_ip_tmp
var_ip=$(cat ip_tmp)
echo "ip source is $var_ip"
