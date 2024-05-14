# Docker
## VM vs Docker
_Virtual Machine_: emulates an hardware machine which can be run in the so called _host_ machine.  
_Docker_: lets you run an application on any operating system.

### Similarities
_Images_: used to create the instance or the container.  
_Versioning_: both can keep track and manage version of the used images.  
_Portability_: the main goal of both, is decrease the difficulty to develop application for differente architectures.  

### Differences
_Virtualization_  
In general it means creating a virtual, fictional, emulated environment. A VM is built on the top of the Hypervisor and has its own OS. A Docker container is built and runs on the top of an already existing shared and _*same*_ OS.  
_Size and performances_  
Since Docker containers are lightweight and run on top of our OS, are faster than a VM.  
_Security_  
The Docker container has the same vulnerabilities of the host OS. The VM has it's own security layers.  
_Replicability_  
Docker is easier to replicate, especially when we face up with multiple applications and therefore multiple instances.

## Docker architecture
See [official docs](https://docs.docker.com/get-started/overview/#docker-architecture) to a visual explaination about the Docker architecture.  
- _Docker client_ is basically our CLI with which we communicate with the Docker daemon.  
- _Docker daemon_ (`dockerd`) does the heavy part, managing images, builds, containers etc.  
- _Docker registry_ is a hub of stored images, like Docker hub.

### Basic concepts
_Docker Container_  
It is an isolated process which doesn't rely on other dependencies, indipendent and portable, which means, it works in the same way as on other machines.

_Docker Image_  
The images hold the files, binaries, libraries and configurations necessary to run the container (which rembember is a process!). There are already official pre-built and maintaind images for example in Docker Hub, like Debian, Ubuntu, Python etc. A part of those offical, it is possible to create custom images by writing _Dockerfile_.  

Principles of images:  
1) Immutable after creation.
2) Composed by layers, which allows you to add changes on the top of it.

_Docker Compose_  
A best practice is that each container should do one thing. So if we need to run multiple services and applications, Docker Compose lets us define all containers and their configuration needed, into a single YAML file.  
- Dockerfile: instructions to build a container.
- Compose file: define the running containers.  

_Docker networks_  
They are virtal networks which allows Dockerfiles to communicate with each other. There are different type of networks, like Bridge, Host, Overlay and Macvlan. See [this video](https://www.youtube.com/watch?v=bKFMS5C4CG0) for more info about Docker networks.  

## Docker volumes
_Volumes_: special directories inside the filesystem accessible by multiple containers and directly managed by Docker.  
_Bind mounts_: links a directory of the filesystem to the container.  
_tmpfs_: temporary and not-persistent data.

Ways to mount volumes:
`--volume [vol-name or host path]:[container-destination]`  
`--mount type=[bind,volume,tmpfs],src=[vol-name or host path],dst=[container-destination]`  
Additionally we can add other flags like `readonly` and `bind-propagation`.  

The only difference between the two is that _--volume_ will create the directory if doesn't exist, while _--mount_ won't do it.

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
*Resources about PID1*:
https://www.padok.fr/en/blog/docker-processes-container
https://cloud.google.com/architecture/best-practices-for-building-containers
https://hasgeek.com/rootconf/2017/sub/what-should-be-pid-1-in-a-container-JQ6nkBv13XeZzR6zAiFsip
https://github.com/krallin/tini

*PID1*, also know as *init*, is the very first UNIX process. In case of zombie ps, means ps which child-ps not waited from their parent-ps, they are usually adopted by _init_ and cleaned properly. 

## CMD vs ENTRYPOINT
The difference is well explained (here)[https://stackoverflow.com/questions/21553353/what-is-the-difference-between-cmd-and-entrypoint-in-a-dockerfile]. Basically they set a default command to be ecexuted when a container start, with the following differences:
- `ENTRYPOINT`: meant to be a fixed command to run at startup. It is still overwriteable with `--entrypoint` flag in `docker run`.
- `CMD`: cover more or less the same pourpose, but if used with entrypoint together, it will be like an optional argument for `ENTRYPOINT`.  

In the following example, _docker-entrypoint.sh_ is set to be run at startap, bringing _/usr/sbin/php-fpm7.4 --nodaemonize_ as arguments.
```docker
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "/usr/sbin/php-fpm7.4", "--nodaemonize" ]
```
In this case, `CMD` can be still overwritten if needed my using `docker run --name [my-container] [my-img] [cmd-to-substitute]`.
___
___
___
## Personal reference
### Docker personal cheatsheet

#### Listing and status
`docker ps -a` display all containers/ps
`docker imges -a` display all images
`docker inspect [image]`

#### Main commands
`docker build -t [image]:[tag] [dir]` builds an image from a Dockerfile  
_--rm_ 

`docker run [image]` minimum
`docker run -u [user] --hostname [host] -it [image]:[tag]`
_-i_ interactive (keeps stdin open)
_-t_ pseudo-TTY which simluates a real terminal
_-d_ detatched mode, means in background
_--rm_ it will ne removed after stop

`docker exec [mycontainer-id] [cmd]` execute a command in a running container

#### Remove ps and images
`docker stop [container-name]` to stop the container

`docker rm [container-name]` remove all stopped containers  
`docker container prune` remove all stopped containers  
`docker rm -vf $(docker ps -aq)` remove all stopped container  

`docker rmi [img-name]` remove all images
`docker rmi -f $(docker images -aq)` remove all images

`docker system prune` rm everything except volumes

#### Docker context
`docker context` verify if context is active  
`ls` list the available context  
`inspect [context-name]` if not specified uses `default`  
`use [context-name]` 
The default context is the one that is 'called' when we use docker commands.

#### Docker context
If you start a container with a volume that doesn't yet exist, Docker creates the volume automatically.
`docker volume create [name]`
`docker volume ls`
`docker volume rm [name]`
`docker volume inspect [name]`

____________________________________________________________________________________
_Tests for the project_
`docker network ls` to list the networks

*Bridge network* 
- Install VM - change the connection to bridge adapter (means the router will be directly connected with the machine, verify its ips)  
- `apt install docker.io -y` and verify the changes in that ip addresses
- run different containers which are automatically connected with the docker0 interface (`bridge link`, `docker inspect bridge`, `ip route`) and try to ping the internet
- Not possible reach an eventual nginx at port 80 by default, need to expose it adding `-p 80:80`  

*User-defind network*  
More raccomanded because every user-defined network is isolated from the others.
- `docker network crate [name]` 
