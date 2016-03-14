FROM ubuntu:trusty
MAINTAINER Fernando Mayo <fernando@tutum.co>, Feng Honglin <hfeng@tutum.co>
#Dockerfile modified by Thibaut Fabre <fabre.thibaut@gmail.com>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install supervisor apache2 libapache2-mod-php5 mysql-server php5-mysql php5 openjdk-7-jdk && \
  rm -rf /var/lib/apt/lists/*  &&\
  echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Create folder, add scripts and change rights
RUN mkdir -p /scripts
ADD scripts/start-apache2.sh /scripts/start-apache2.sh
ADD scripts/start-mysqld.sh /scripts/start-mysqld.sh
ADD scripts/run.sh /scripts/run.sh
ADD scripts/setup-mysql.sh /scripts/setup-mysql.sh
RUN chmod 755 /scripts/*.sh

# Add configuration
ADD conf/my.cnf /etc/mysql/conf.d/my.cnf
ADD conf/supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD conf/supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Add script adding MySQL user
ADD scripts/create-mysql-user.sh /scripts/create-mysql-user.sh
RUN chmod 755 /scripts/*.sh

# config ssl on apache2
ADD scripts/setup-ssl.sh /scripts/setup-ssl.sh
RUN chmod 755 /scripts/*.sh
RUN rm -rf /etc/apache2/sites-available/*	
ADD conf/default-ssl /etc/apache2/sites-available/default-ssl.conf
ADD conf/default /etc/apache2/sites-available/000-default.conf
RUN mkdir -p /etc/apache2/ssl
ADD cert/server.crt /etc/apache2/ssl/server.crt
ADD cert/server.key /etc/apache2/ssl/server.key
RUN chmod o-rw /etc/apache2/ssl/server.key


# Configure /app folder with the app
ADD JavHackard.tar /app/
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html && chown -R www-data /app && chown  www-data /app/files/*


# Add volumes for MySQL 
#VOLUME  ["/etc/mysql", "/var/lib/mysql" ]

#Define the JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/

EXPOSE 443 3306

CMD bash -C '/scripts/run.sh'; bash

