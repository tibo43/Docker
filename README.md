# Docker

## What?
Files to build and run a Docker container

## Why?
To host a secure webapp 

## How?
Use and alteration a Dockefile and files of <br />
Fernando Mayo <fernando@tutum.co> and Feng Honglin <hfeng@tutum.co> <br />
Layer base : Ubunu 14.0.4 LTS <br />
Pacakge install : Apache2, PHP5, MySQL, java

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

To manage the DB on a running container, the admin had to use the command line <br \>
```Shell
mysql -uadmin -p<PASSWORD> -h<HOST>
#example
#mysql -uadmin -pazerty -h172.17.0.2
```

## Future?

Install java and test java command.

## Important

Modify in open-bdd.php the login from 'root' to 'admin'
