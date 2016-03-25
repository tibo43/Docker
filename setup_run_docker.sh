#!/bin/sh

echo "Type your mysql password"
read PASSWORD
echo > JavHackard/files/khdfgeaqejalh/bdd
echo $PASSWORD > JavHackard/files/khdfgeaqejalh/bdd

PASS=$(cat JavHackard/files/khdfgeaqejalh/bdd)
echo "=> Creating MySQL admin user with $PASS password"

### Build the Docker image from the Dockerfile
docker build -t dockerweb .

### Apply firewall rules in the host
./setup_fw.sh

### Run the images of our image build previously
docker run -i -t --rm --name docker_server_web dockerweb
