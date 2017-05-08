#!/bin/sh

var_ip=$(cat ip_tmp)

echo "<VirtualHost *:80>" > conf/default
echo "	ServerName JavHackard" >> conf/default
echo "	Redirect / https://$var_ip" >> conf/default
echo "</VirtualHost>" >> conf/default
