#!/bin/sh

NAME = dockerweb

### Build the Docker image from the Dockerfile
docker build -t $NAME .

### Apply firewall rules in the host
./setup_fw.sh

### Run the images of our image build previously
docker run -t i --name docker_server_web $NAME
