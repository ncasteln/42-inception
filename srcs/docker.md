# Docker concepts
As declared before, this is not a real tutorial. I suggest you to start from the official documentation to understand Docker, or watch some related videos. This is a collection of notes I took, to resume the concepts I grasped. Myabe you'll find useful too.

## Index
1. [VM vs Docker](#vm-vs-docker)
2. [Basic concepts](#basic-concepts)
3. [PID 1](#pid1)
4. [CMD vs ENTRYPOINT](#cmd-vs-entrypoint)
5. [Quick docker reference](#quick-docker-reference)
6. [Docker compose](#docker-compose)

## VM vs Docker
- _Virtual Machine_: emulates an hardware machine which can be run in the so called _host_ machine.
- _Docker_: lets you run an application on any operating system.  

Similarities:
- _Images_: used to create the instance/container.  
- _Versioning_: both can keep track and manage version of the used images.  
- _Portability_: the main goal of both, is decrease the difficulty to develop application for different architectures.  

Differences:
- _Virtualization_: in general it means creating a virtual, fictional, emulated environment. A VM is built on the top of the Hypervisor and has its own OS. A Docker container is built and runs on the top of an already existing shared OS.  
- _Size and performances_: since Docker containers are lightweight and run on top of our OS, are faster than a VM.  
- _Security_: the Docker container has the same vulnerabilities of the host OS. The VM has it's own security layers.  
- _Replicability_: Docker is easier to replicate, especially when we face up with multiple applications and therefore multiple instances.

## Basic concepts
Before going through some concepts, this is a brief list on a couple things to pay attention:
- Dockerfile, docker CLI and docker compose. They are just three different ways to accomplish _mostly_ the same things. You can set up the LEMP also by using Dockerfiles without docker compose, and you can mount volumes thorugh the CLI, or writing them in Dockerfile, or define them in compose. The same Dockerfile rule can be probably defined as well in the CLI and in compose.
- Read about environment variables, and don't make the mistake I did, by thinking: "Oh yeah, credentials, I'll make them really secret only before the evaluation". Read [here](#env) in the section which talks about _.env_.
- Take in account, that docker has a lot of caching. Sometimes data could persist between build and runs, so try to understand if it is the case and if you need to remove eventual shared mounted volumes. If you need to delete related to docker, including images, containers, volumes, network, you can use `docker system prune`. If something persist to don't work but it should, consider the idea to log out, or if you can `sudo systemctl restart docker`.

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
```bash
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
- `docker volume create [name]`
- `docker volume ls`
- `docker volume rm [name]`
- `docker volume inspect [name]`

## Docker compose
To learn about docker compose I first tried to compose the architecture required by the subject, using the official docker image for each required service. I follow the built explained in [this tutorial](https://bobcares.com/blog/docker-compose-nginx-php-fpm-mysql-wordpress/) and after verifying its functionality, I played around it, making some adjustments and changed some paramteres.  

A very important reference I used to get the syntax and learn some concepts is the [docker compose sepcification](https://github.com/compose-spec/compose-spec/blob/master/spec.md).  

The stack infrastructure requested the subjects is a _LEMP_:
- **L**-inux.
- **E**-nginx (yes, E stays for the way how we have to pronunce nginx).
- **M**-ySql (or MariaDB, MongoDB etc.).
- **P**-hp.

### What we have and what they do
A big challange at the beginning of the project was to grasp effectively the job of every layer of the stack, understanding where a service starts and end. Here I will try to give a brief and easy explaination without too many techincal terms. It is obviously a _SIMPLIFIED_ version of what actually happens, to take as an introduction of the topic.

0) Everything start from a common user, called _Mr Brown_, how wants to navigate on the Internet to a specific website called _www.helloworld.com_. He wants some content, like any other person who navigate on the web. We can imagine it like a letter in which is explicitly written the request for some contents. After typing the address of _ncasteln.42.fr_ in the browser, Mr Brown presses Enter, and the request of those contents starts, his letter is sent to the destination.
1) The first layer the request meets, is a _web server_, in our case nginx. Since Mr Brown is not the only one who requests those contents, we need multiple workers who can handle all of them. Nginx provides those workers, and each worker knows his job: process the request and look for a response. Because of their contract (in other words, because of the nginx configuration), the workers know that in case of request of _ncasteln.42.fr_, a _.php_ script has to be executed. But they don't have the skills of executing it (because of the nature of nginx), so they pass the request to _PHP-FPM_, which holds those skills.
2) _PHP-FPM_ is the second layer of our architecture, which stays in the same container of Wordpress. Actually Wordpress _NEEDS_ php to work. PHP recieves a request form nginx to execute a script, which will generate an _html_ file with the content requested by Mr Brown. [But why we are here at this step? Why php? Why not serving the content simply and directly?](https://medium.com/@networsys/what-is-php-how-is-php-used-in-wordpress-a05d32be9531). After reading the article, we can assume that php is the tecnology used by Wordpress, and _PHP-FPM_ in particular can share the data at high efficency and performance.
3) By executing the script, PHP will create and _html_ file by looking at the _MariaDB_ database [in case of needs](https://codex.wordpress.org/Database_Description), and returns it to nginx, which will respond to the initial request of _Mr. Brown_, who just blinked his eyes in this millisecond, and can now read the desired page.

### How to test if everything is set up correctly
If you compose the stack using the docker hub official images, then you would like to understand if it works properly. Well, to test it, simply access to `http` or `https` (depending id you enabled SSL) at `localhost:[port-you-opened]`. The result of this should be the wordpress installation page. Pay attention that some browser try to autocomplete the _http_ to _https_.  
Another smart way is using _curl_ in the command line with `curl -I localhost:[port-you-opened]`, and read carefully the output.  

These are other tests and changes that I tried to play with the created infrastructure:
- Change `ports` to `expose` (see [ports vs expose](#ports-vs-expose)).
- Get rid of the default network and create a custom one (see [networks](#networks)).
- Move the variables into `.env` files, using `env_file` directive in docker-compose instead of `environment`, but pay attention, read the chapter about [.env](#env).

### networks
[This video](https://www.youtube.com/watch?v=bKFMS5C4CG0) (and in general this author) is a very nice starting point for understanding networks. Here is a brief resume of how them works. Important to knoe is if none of the service has a specified network, a _default network connection_ for that service is created automatically by docker. If every service has a specified network, no default network is created, and they will be in different network, in other words isolated from each other.

To test it you can use `docker network list` to display the networks after compose in both cases. In case no network is specified, you should see a default one, which is not there in case each service has a specified one.

Check paramters by using `docker network inspect [network-name]` and also `docker container inspect [container-name]`. Very important to note, is that when a service is assigned to a network, it has its own randomly generated IP address, which it is not visibile from the other services. But if you carefully inspect the container and network specification, you'll notice that the containers can be identified by that IP Address, and an _alias_ which traduces it for the other services. So for example, nginx needs to know to which address redirect the client's request, and the only way to set in the configuration before startup, is using the alias given to wordpress. Check the documentation, and try to add a different alias to the container network.  

A good way to verify if the connections are working properly and you containers can communicate, is by using [ping](https://linux.die.net/man/8/ping).

By looking at the [subject](../en.subject.pdf) you will notice that at page 7 there is a diagram which represents the infrastructure. However it is explicitly written that it is just an example, that because I didn't agree to put all the services under the same network, but instead i created 2 of them, to isolate the network of wordpress-nginx, from the network wordpress-mariadb.

### .env
when I started the project I understimated the importantce of maintain some sensitive data (password, usernames) protected by the look of everyone. Simply said, I planned to hide this data right before the evaluation, but a morning I woke up and thought: _"GIT!!!"_ like the mother in [Home Alone](https://en.wikipedia.org/wiki/Home_Alone) when realized that she left Kevin at home.  
The simple problem is, that the sensitive data I was planning to remove right before the evaluation, it was already spreaded in the git repo, so retrieveable by just anyone how knows on how to inspect a previous commit.  
Well, this is learn by doing and also by NOT doing. If you came to this point in time, you can avoid from start using a `.gitignore` file. If not, not everything is lost. You can modify the history by removing the files or folder you don't want, but remember: this has to be the last time you did this stupid thing. Here is a learn project, in the real world would mean losing real money because of you.

Check this articles to get rid of it. There are basically different ways to do it. Here is reported one of the two i used.
- https://stackoverflow.com/questions/307828/how-do-you-fix-a-bad-merge-and-replay-your-good-commits-onto-a-fixed-merge
- https://github.com/newren/git-filter-repo/tree/main
