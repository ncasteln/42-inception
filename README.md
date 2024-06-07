# 42-inception
## Keywords
docker - dockerfile - docker compose - containers - LEMP - web server - nginx - mariadb - wordpress - Virtual Machine

## Subject
In this 42 project, we have to create a LEMP stack infrastructure using Docker and expecially Docker compose. It is not allowed to use already made images from the Docker Hub service, and other special requirements are writtend in the [official provided subject](./en.subject.pdf). In general, the goal of the project is to teach you about Dockerfile and docker compose, understanding the basic concepts of this tool.

## About this docs
A brief note about this documentations: if you are looking for a **Complete guide to Inception** you won't find it here. This has to be considered a learn-by-doing-walkthorugh, which assumes that in the moment you find a word that you don't understand, you'll going to reasearch it. Don't also expect that I'll explain every point, because I won't. The docs will also appear incomplete, because the pourpose is not to write a tutorial, but a personal resume of the project, containing concept and references I grasped and keep track of them, and also yes, give you some pills and hints.

## Inception index
0) [Try the project](#try-it-out)
1) [How to start](#how-to-start)
2) [Docker concepts](./srcs/docker.md)
3) [Nginx](./srcs/requirements/nginx/nginx.md)
4) [Mariadb](./srcs/requirements/mariadb/mariadb.md)
5) [Wordpress & php-fpm](./srcs/requirements/wordpress/wordpress.md)

## Try it out
I tried to make the project as ready as possible to allow the user to try it on its own system. So theorically it should be just cloned and made. The rest should be done by the scripts, which will guide you through the right configuration.
```bash
$ git clone https://github.com/ncasteln/42-inception inception;
$ cd inception && make;
```
**Note**: the `Makefile` contains a tons of rules. Some of them were for me just useful for the first steps of the project and they could be obsolete. I have added a lot of clean-up rules, that you should run carefully, to avoid undesired deletions.

## How to start
How I started, is not what I would suggest. I started by doing the single Dockerfile for each services, but at the end I had no idea if they were really functional. Therefore I suggest to start building a Docker compose file, using docker-hub official images of nginx, wordpress and mariadb, which are actually not allowed by the subject. Once this compose it is functional, it will be possible to build your own images one by one, and substitute them, one by one. If the substitution of your custom container doesn't broke the functionality, it means that it is mostly correct, so you can go thorugh the next step. If something is broken, don't go on to the next step and adjust what you've done. In other words, be sure to understand where the error comes from.  

This said, the steps I suggest are the following:
1) **Learn the basics of Docker**.  
What is it, how it internally works, difference from a VM, build an image, run and stop a container, cleanup everything, writing Dockerfiles, docker compose and more. It's not necessary that you grasp everything at once at the beginning, but the more you go, the more you'll need.

2) **Write a docker compose**.  
Start by compose using the official docker-hub images of nginx, wordpress and mariadb. Make the LEMP stack functional and improve it the more as you can. Play around the set up, understand the relation between the services, try some experiment in the configuration and try to get the chain of the services you set up.

3) **Nginx container**.  
Start writing an _nginx_ Dockerfile to substitute the docker-hub image previously used for it, and consequently the container. Start easy, don't try to implement immediatly SSL, just provide a simple configuration which, I repeat, has to be *FUNCTIONAL*. If it is not functional, no problem, goes to the next ste...NOOOOOO! Make it functional. Why starting with nginx? Because it's the easiest one.

4) **Mariadb and Wordpress**.  
Go on writing the other Dockerfiles, one by one, either Wordpress or mariadb. One by one, means the same as the point above, so once mariadb is ready and functional, and it does't broke the whole infrastructure, go to write the Dockerfile for Wordpress. This approach is prety redundant, but I ensure that is the easiest one.

5) **Experiment and play**.  
Is it everything functional? You can refine your Dockerfiles, modify configurations, remove, improve, add and fix, whatever you want. What is the minimal configuration? What are the key points? Just play around it, learn by doing and secure your knowledge.

6) **Virtual Machine**.  
When everything is ready, you can think about the Virtual Machine.
