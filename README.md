# Docker

## What?
Files to build and run a Docker container

## Why?
To host a secure webapp 

## How?
Use and alteration a Dockefile and files of <br />
Fernando Mayo <fernando@tutum.co> and Feng Honglin <hfeng@tutum.co> <br />
Layer base : Ubunu 14.0.4 LTS <br />
Pacakge install : Apache2, PHP5, MySQL

## How to?
Tar webapp folder with the name JavHackard.tar <br />
Move the tar with the others files of build Docker

Build
```Shell
docker build -t name_of_image path_of_dockerfile
#example
# docker build -t serverweb .
```

Run
```Shell
docker run -i -t name_of_image
#example
# docker run -i -t serverweb
```
