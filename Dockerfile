FROM ubuntu:trusty
MAINTAINER Fernando Mayo <fernando@tutum.co>, Feng Honglin <hfeng@tutum.co>
# Dockerfile modified by Thibaut Fabre <fabre.thibaut@gmail.com>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install supervisor apache2 libapache2-mod-php5 mysql-server php5-mysql php5 openjdk-7-jdk && \
  rm -rf /var/lib/apt/lists/*  &&\
  echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
  echo "ServerTokens Prod" >> /etc/apache2/apache2.conf && \
  echo "ServerSignature Off" >> /etc/apache2/apache2.conf
	

# Create folder, add scripts and change rights
RUN mkdir -p /scripts

## Script for start apache2 and mysql
ADD scripts/start-apache2.sh /scripts/start-apache2.sh
ADD scripts/start-mysqld.sh /scripts/start-mysqld.sh

## Scripts for create and import db and create a user called admin
ADD scripts/setup-mysql.sh /scripts/setup-mysql.sh
ADD scripts/create-mysql-user.sh /scripts/create-mysql-user.sh

## Script for setup ssl module
ADD scripts/setup-ssl.sh /scripts/setup-ssl.sh

## Script to launch all the setup and start services (mysql,apache2,supervisord)
ADD scripts/run.sh /scripts/run.sh

## Change rights of files into scripts' folder
RUN chmod 755 /scripts/*.sh

# Add files' configuration

## Add my own conf of mysql
ADD conf/my.cnf /etc/mysql/conf.d/my.cnf

## Add configuration files of apache2 and mysqld into supervisord
ADD conf/supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD conf/supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# config SSL on apache2

## Delete entry-level configuration and add my own configuration
RUN rm -rf /etc/apache2/sites-available/*
ADD conf/default-ssl /etc/apache2/sites-available/default-ssl.conf
ADD conf/default /etc/apache2/sites-available/000-default.conf

## Add ssl certificat and key into a new folder /etc/apache2/ssl and change rights of the key file.
RUN mkdir -p /etc/apache2/ssl
ADD cert/server.crt /etc/apache2/ssl/server.crt
ADD cert/server.key /etc/apache2/ssl/server.key
RUN chmod o-rw /etc/apache2/ssl/server.key


# Configure /app folder with the app and link it within /var/www/html and change owner of folder and file
ADD JavHackard/ /app/
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html && chown -R www-data /app && chown www-data /app/files/*


# Add volumes for MySQL 
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]

# Define ENVIRONMENT
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/
ENV APACHE_RUN_USER www-data

# Define ports that docker listen
EXPOSE 443 3306

# Launch the container docker with the script run.sh
CMD bash -C '/scripts/run.sh'; bash

