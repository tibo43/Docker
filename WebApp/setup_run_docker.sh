#!/bin/sh

echo "Type your mysql password"
read PASSWORD
echo > JavHackard/files/khdfgeaqejalh/bdd
echo $PASSWORD > JavHackard/files/khdfgeaqejalh/bdd

PASS=$(cat JavHackard/files/khdfgeaqejalh/bdd)
echo "=> Creating MySQL admin user with $PASS password"

### Find IP address of the interface
./find_ip.sh

### Configuration of default apache2
./config_default_apache2.sh

### Build the Docker image from the Dockerfile
docker build -t dockerweb .

### Apply firewall rules in the host
./setup_fw.sh

### Run the images of our image build previously
docker run -i -t --rm --name docker_server_web dockerweb
