#!/bin/sh

### Access to the shell of the running Docker container

## Find the running  docker container
ID = docker inspect --format="{{.Id}}" docker_server_web

## Exec a bash into the container
docker exec -ti $ID bash
