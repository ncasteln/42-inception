# 42-inception
## Keywords
docker - dockerfile - docker compose - containers - LEMP - web server - nginx - mariadb - wordpress - Virtual Machine

## Subject
In this 42 project, we have to create a LEMP stack infrastructure using Docker and expecially Docker compose. This has to be considered a learn-by-doing-walkthorugh, which assumes that in the moment you find a word that you don't understand, you'll going to reasearch it. Don't also expect that I'll explain every point, because I won't. I firstly consider those readme files a personal resume of the project, containing concept and references I grasped and keep track of them. If you find something that could be improved, don't hesitate to make a pull request.

## Inception index
1) [How to start](#how-to-start)
2) [Docker concepts](./srcs/docker.md)
3) [Nginx](./srcs/requirements/nginx/nginx.md)
4) [Mariadb](./srcs/requirements/mariadb/mariadb.md)
5) [Wordpress](./srcs/requirements/wordpress/wordpress.md)

## Try it out
I tried to make the project as ready as possible to allow the user to try it on its own system. So theorically it should be just cloned and made. The rest should be done by the scripts, which will guide you through the right configuration. 
```bash
$ git clone https://github.com/ncasteln/42-inception inception;
$ cd inception && make;
```
Note: the `Makefile` contains a tons of rules. Some of them were for me just useful for the first steps of the project and they could be obsolete. I have added a lot of clean-up rules, that you should run carefully, to avoid undesired deletions.

## How to start the project
How I started, is not what I would suggest. I started by doing the single Dockerfile for each services, but at the end I had no idea if they were really functional. Therefore I suggest to start building a Docker compose file, using docker-hub official images of nginx, wordpress and mariadb, which are actually not allowed by the subject. Once this compose it is functional, it will be possible to build your own images one by one, and substitute them, one by one. If the substitution of your custom container doesn't broke the functionality, it means that it is mostly correct, so you can go thorugh the next step. If something is broken, don't go on to the next step and adjust what you've done. In other words, be sure to understand where the error comes from.  

This said, the steps I suggest are the following:
1) Learn the basics of Docker: what is it, how it internally works, difference from a VM, build an image, run and stop a container, cleanup everything, writing Dockerfiles, docker compose and more. It's not necessary that you grasp everything at once at the beginning, but the more you go, the more you'll need.
2) Write a docker compose file which uses the official docker-hub images of nginx, wordpress and mariadb. Make the LEMP stack functional and improve it the more as you can. Play around the set up, understand the relation between the services, try some experiment in the configuration and try to get the chain of the services you set up.
3) Start writing an _nginx_ Dockerfile to substitute the docker-hub image previously used for it, and consequently the container. Start easy, don't try to implement immediatly SSL, just provide a simple configuration which, I repeat, has to be *FUNCTIONAL*. If it is not functional, no problem, goes to the next ste...NOOOOOO! Make it functional. Why starting with nginx? Because it's the easiest one.
4) Go on with the other Dockerfiles, one by one, either Wordpress or mariadb. One by one, means the same as the point above, so once mariadb is ready and functional, and it does't broke the whole infrastructure, go to write the Dockerfile for Wordpress. This approach is prety redundant, but I ensure that is the easiest one.
5) Is it everything functional? You can refine your Dockerfiles, improve them, add and fix, whatever you want. Just play around it, and learn by doing.
6) When everything is ready, you can think about the Virtual Machine.
