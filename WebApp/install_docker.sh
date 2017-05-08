#!/bin/sh

## Purge the possible old version
apt-get purge lxc-docker*
apt-get purge docker.io*
apt-get update
apt-get -y install apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

## Install the new version
mv /etc/apt/sources.list.d/docker.list /etc/apt/sources.list.d/docker.list.old
echo "deb https://apt.dockerproject.org/repo debian-jessie main" >> /etc/apt/sources.list.d/docker.list
apt-get -y update 
apt-get -y install docker-engine

## Launch 
service docker restart
echo "Docker installation ==> Done"
