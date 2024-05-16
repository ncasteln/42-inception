# 42-inception

In this 42 project, we have to create a LEMP stack infrastructure using Docker and expecially Docker compose. This has to be considered a learn-by-doing-walkthorugh, which assumes that in the moment you find a word that you don't understand, you'll going to reasearch it. A part of the guide flavour I give, it'll be also a personal resume of the project, containing concept and references I grasped.

## Index
1) [How to start](#how-to-start)
2) [Docker concepts](#docker-concepts)
3) [Docker compose](./srcs/README.md)
4) [Nginx](./srcs/requirements/nginx/README.md)
5) [Mariadb](./srcs/requirements/mariadb/README.md)
6) [Wordpress](./srcs/requirements/wordpress/README.md)

## How to start
How I start, is not what I would suggest. I started by doing the single Dockerfile for each services, but at the end I had no idea if they were really functional. Therefore I suggest to start building a Docker compose file, using dokcer-hub official images of nginx, wordpress and mariadb. Once it is functional, it is possible to build your own images one by one, and substitute them, one by one. If the substitution of your custom container doesn't broke the functionality, it means that it is mostly correct, so you can go thorugh the next step. If something is broken, don't go on to the next step. In other words, be sure to understand where the error come from.  
That said, the steps I suggest are the following:
1) Learn the basics of Docker: what is it, how it internally works, difference from a VM, build an image, run and stop a container, cleanup everything, writing Dockerfiles, docker compose and more.
2) Write a docker compose file which uses the official docker-hub images of nginx, wordpress and mariadb. Make the stack functional and improve the more as you can. In this step you can play around the set up, understand the relation between the services, try some experiment in the configuration.
3) Start writing an _nginx_ Dockerfile to substitute the docker-hub image previously used for it, and consequently the container. Start easy, don't try to implement immediatly SSL, just provide a simple configuration which, I repeat, has to be *FUNCTIONAL*. If it is not functional, no problem, goes to the next ste...NOOOOOO! Make it functional.
4) Go on with the other Dockerfiles, one by one, either Wordpress or mariadb. One by one, means the same as the point above, so once mariadb is ready and functional, and it does't broke the whole infrastructure, go to write the Dockerfile for Wordpress.
5) Is it everything functional? You can refine your Dockerfile, improve them, add and fix, whatever you want. Just play around it, and learn by doing. 
6) In the last step of the project you can set up a VM which will host your infrastructure.

## Docker concepts
As declared before, this is not a guid to Docker. The official documentation it is already well written, therefore I suggest you to start from there to understand Docker. This is a collection of notes I took, to resume the concepts I grasped.

## Index
1. [VM vs Docker](#vm-vs-docker)
2. [Docker architecture](#docker-architecture)
3. [Basic concepts](#basic-concepts)
4. [PID 1](#pid1)
5. [CMD vs ENTRYPOINT](#cmd-vs-entrypoint)
6. [Quick docker reference](#quick-docker-reference)

## VM vs Docker
- _Virtual Machine_: emulates an hardware machine which can be run in the so called _host_ machine.
- _Docker_: lets you run an application on any operating system.  

Similarities:
- _Images_: used to create the instance or the container.  
- _Versioning_: both can keep track and manage version of the used images.  
- _Portability_: the main goal of both, is decrease the difficulty to develop application for differente architectures.  

Differences:
- _Virtualization_: in general it means creating a virtual, fictional, emulated environment. A VM is built on the top of the Hypervisor and has its own OS. A Docker container is built and runs on the top of an already existing shared OS.  
- _Size and performances_: since Docker containers are lightweight and run on top of our OS, are faster than a VM.  
- _Security_: the Docker container has the same vulnerabilities of the host OS. The VM has it's own security layers.  
- _Replicability_: Docker is easier to replicate, especially when we face up with multiple applications and therefore multiple instances.

## Docker architecture
See [official docs](https://docs.docker.com/get-started/overview/#docker-architecture) to a visual explaination about the Docker architecture.  
- _Docker client_ is basically our CLI with which we communicate with the Docker daemon.  
- _Docker daemon_ (`dockerd`) does the heavy part, managing images, builds, containers etc.  
- _Docker registry_ is a hub of stored images, like Docker hub.

## Basic concepts
Before going through some concepts, this is a brief list on a couple things to pay attention:
- Dockerfile, docker CLI and docker compose. They are just three different ways to accomplish _mostly_ the same things. You can set up the LEMP also by using Dockerfiles without docker compose, and you can mount volumes thorugh the CLI, or writing them in Dockerfile, or define them in compose. The same Dockerfile rule can be probably defined as well in the CLI and in compose.
- Read about environment variables, and don't make the mistake I did, by thinking: "Oh yeah, secrets, I'll make them really secret only before the evaluation". Read [here](./srcs/README.md) in the section which talks about _.env_.
- Take in account, that docker has a lot of caching. Sometimes data could persist between build and runs, so try to understand if it is the case and if you need to remove eventual shared mounted volumes. If you need to delete related to docker, including images, containers, volumes, network, you can use `docker system prune`.

_Docker Container_  
It is an isolated process which doesn't rely on other dependencies, indipendent and portable, which means, it works in the same way as on other machines.

_Docker Image_  
The images hold the files, binaries, libraries and configurations necessary to run the container (which rembember is a process!). There are already official pre-built and maintaind images for example in Docker Hub, like Debian, Ubuntu, Python etc. A part of those offical, it is possible to create custom images by writing _Dockerfile_.  

Principles of images:  
1) Immutable after creation.
2) Composed by layers, which allows you to add changes on the top of it.

_Docker Compose_  
A best practice is that each container should do one thing. So if we need to run multiple services and applications, Docker Compose lets us define all containers and their configuration needed, into a single YAML file.  
- Dockerfile: instructions to build an image.
- Compose file: define the running containers.  

_Docker networks_  
Virtal networks which allows Dockerfiles to communicate with each other. There are different type of networks, like Bridge, Host, Overlay and Macvlan. See [this video](https://www.youtube.com/watch?v=bKFMS5C4CG0) for more info about Docker networks.  

## Docker volumes
_Volumes_ are special directories inside the filesystem accessible by multiple containers and directly managed by Docker. Their pourpose is to persist data in your container between builds. We have:
- _Bind mounts_: links a directory of the filesystem to the container.  
- _tmpfs_: temporary and not-persistent data.

Ways to mount volumes:
- `--volume [vol-name or host path]:[container-destination]`. If the directory doesn't exist, this command will create it.
- `--mount type=[bind,volume,tmpfs],src=[vol-name or host path],dst=[container-destination]`. It won't create the directory.
- Additionally we can add other flags like `readonly` and `bind-propagation`.  

Try to see:
```docker
# create a volume and check it
docker volume create my-vol
docker volume inspect my-vol

# run a new nginx container and create three files in my-vol
# docker run --name first-nginx --mount type=volume,src=my-vol,dst=/etc/hello --detach nginx:latest
docker run --name first-nginx --volume my-vol:/etc/hello --detach nginx:latest
docker exec first-nginx touch /etc/hello/world-1 /etc/hello/world-2 /etc/hello/world-3

# run a new nginx container and check if the file are there
# docker run --name second-nginx --mount type=volume,src=my-vol,dst=/etc/hello --detach nginx:latest
docker run --name second-nginx --volume my-vol:/etc/hello --detach nginx:latest
docker exec first-nginx ls -la /etc/hello

# you can additionally stop the two nginx and delete them, and create another container to check if the data created before persists
```

## PID1
*PID1*, also know as *init*, is the very first UNIX process. In case of zombie ps, means ps whose parent-ps didn't wait for them, are usually adopted by _init_ and cleaned properly. It is an important concept in Docker: which process takes PID 1 when you run a container, since it behaves differently from a real unix boot? You can observe it by running a container and use the utility `ps aux`.

Some resources to learn about PID 1, init, tini and everything related:  
+ https://www.padok.fr/en/blog/docker-processes-container  
+ https://cloud.google.com/architecture/best-practices-for-building-containers
+ https://hasgeek.com/rootconf/2017/sub/what-should-be-pid-1-in-a-container-JQ6nkBv13XeZzR6zAiFsip
+ https://github.com/krallin/tini

## CMD vs ENTRYPOINT
**CMD** and **ENTRYPOINT** are two directives for Dockerfile. Both allows you to run a script by startup, which should boot our system and service. The difference is well explained [here](https://stackoverflow.com/questions/21553353/what-is-the-difference-between-cmd-and-entrypoint-in-a-dockerfile). Basically they set a default command to be ecexuted when a container start, but with the following differences:
- `ENTRYPOINT`: meant to be a fixed command to run at startup. It is still overwriteable with `--entrypoint` flag in `docker run`.
- `CMD`: cover more or less the same pourpose, but if used with entrypoint together, it will be like an optional argument for `ENTRYPOINT`. Why is it useful? Because maybe you have an entrypoint script, which if recieve some arugment can change its beahvior. Therefore you can write a Dockerfile, which has a default beahvior, and another behavior like for example logging, checking some conf file.  

In the following example, _docker-entrypoint.sh_ is set to be run at startap, bringing _/usr/sbin/php-fpm7.4 --nodaemonize_ as arguments. **CMD** can be still overwritten if needed, by using `docker run --name [my-container] [my-img] [cmd-to-substitute]`.
```docker
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "/usr/sbin/php-fpm7.4", "--nodaemonize" ]
```

## Quick docker reference
### Listing and status
- `docker ps -a` display all containers/ps
- `docker imges -a` display all images
- `docker inspect [image]`

### Build and run
- `docker build -t [image]:[tag] [dir]` builds an image from a Dockerfile   
- `docker run [image]` minimum
- `docker run -u [user] --hostname [host] -it [image]:[tag]`. Possible options:
	- _-i_ interactive (keeps stdin open)
	- _-t_ pseudo-TTY which simluates a real terminal
	- _-d_ detatched mode, means in background
	- _--rm_ it will ne removed after stop
- `docker exec [mycontainer-id] [cmd]` execute a command in a running container

### Remove ps and images
- `docker stop [container-name]` to stop the container
- `docker rm [container-name]` remove all stopped containers  
- `docker container prune` remove all stopped containers  
- `docker rm -vf $(docker ps -aq)` remove all stopped container  
- `docker rmi [img-name]` remove all images
- `docker rmi -f $(docker images -aq)` remove all images
- `docker system prune` rm everything except volumes

### Volumes
If you start a container with a volume that doesn't yet exist, Docker creates the volume automatically.
`docker volume create [name]`
`docker volume ls`
`docker volume rm [name]`
`docker volume inspect [name]`
