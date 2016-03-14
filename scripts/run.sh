#!/bin/bash

#PATH=/usr/local/jvm/jdk1.7.0/bin:$PATH
#export PATH

VOLUME_HOME="/var/lib/mysql"


sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini
if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"  
    /scripts/create-mysql-user.sh
else
    echo "=> Using an existing volume of MySQL"
fi

/scripts/setup-ssl.sh

exec supervisord -n
