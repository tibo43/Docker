#!/bin/bash
DIR=/dev/null
service apache2 start >$DIR
a2enmod ssl >$DIR
a2ensite default-ssl.conf >$DIR
service apache2 reload >$DIR
service apache2 stop >$DIR
