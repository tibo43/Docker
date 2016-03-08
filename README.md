# Docker

## What?
Files to build and run a Docker container

## Why?
To host a secure webapp 

## How?
Use and alteration a Dockefile and files of Fernando Mayo <fernando@tutum.co>, Feng Honglin <hfeng@tutum.co>
Layer base : Ubunu 14.0.4 LTS
Pacakge install : Apache2, PHP5, MySQL

## How to?
Tar webapp folder with the name JavHackard.tar
Move the tar with the others files of build Docker

Build
'''shell
docker build -t name_of_image path_of_dockerfile
#example
# docker build -t serverweb .
'''

Run
'''shell
docker run -i -t name_of_image
#example
# docker run -i -t serverweb
'''
