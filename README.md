# Docker

## What?
Files to build and run a Docker container

## Why?
To host a secure webapp 

## How?
Use and alteration a Dockefile and files of <br />
Fernando Mayo <fernando@tutum.co> and Feng Honglin <hfeng@tutum.co> <br />
Layer base : Ubunu 14.0.4 LTS <br />
Layer added : Apache2, PHP5, MySQL, java

## How to?
Tar webapp folder with the name JavHackard.tar into the Docker <br />

To build:
```Shell
docker build -t name_of_image path_of_dockerfile
#example
# docker build -t serverweb .
```

To run:
```Shell
docker run -ti name_of_image
#example
# docker run -ti serverweb
```

To access into the running container:
```Shell
docker ps
#copy the id_container of our container
docker exec -ti id_container bash
```

To manage the DB on a running container, the admin had to use the command line:
```Shell
mysql -uadmin -p<PASSWORD> -h<HOST>
#example
#mysql -uadmin -pazerty -h172.17.0.2
```

## Future?

In dockerfiles, echo in apache2.conf ServerTokens Prod
Check open ports 111, 22 (Iptables)
Create script to build image, to launch container, to access into container and to manage DB

## Important

Modify in open-bdd.php the login from 'root' to 'admin'
