#!/bin/sh

var_ip=$(cat ip_tmp)

echo "<VirtualHost *:80>" >> conf/000_default
echo "ServerName JavHackard" >> conf/000_default
echo "Redirect / https://$var_ip" >> conf/000_default
echo "</VirtualHost>" >> conf/000_default
