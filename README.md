# docker compose

To learn docker compose I first tried to compose the architecture required by the subject, using the official docker image for each required service. I follow the built explained in (this tutorial)[https://bobcares.com/blog/docker-compose-nginx-php-fpm-mysql-wordpress/] and I played around it, making some adjustments and changing some paramteres. These are some tests and changes that I tried:
- Get rid of the default network and create a custom one (see [networks](#networks)).
- Change `ports` to `expose` (see [port vs expose](#port-vs-expose)).
- Move the variables into `.env` files, using `env_file` directive in docker-compose instead of `environment`.

## TO UNDERSTAND
-------- before everything: make data not persistent otherwise it is problematic (TON OF FILES)
-------- restart: always --- why should I use it ?
-------- tiny and init thing?

## port vs expose
Check (here)[https://stackoverflow.com/questions/40801772/what-is-the-difference-between-ports-and-expose-in-docker-compose] the difference between the two statements and how to verify it.

## volumes
A physical host file system is mounted/plugged with the virtual file system of the container.

```docker
services:
  my-service-1:
    volumes:
    - my-vol:/etc/nginx/
  my-service-2:
    volumes:
    - my-vol:/etc/nginx/

volumes:
  my-vol
```

## networks
If one of the service has not a specified network, a default network connection for that service is created automatically by docker. If every service has a specified network, no default network is created.
### How to test it
`docker network list` to display the networks after compose; there should be no default network. After that, try to add a new service without a network specification, and verify newly the network list.

https://tuto.grademe.fr/inception/#accueil

(docker compose sepcification)[https://github.com/compose-spec/compose-spec/blob/master/spec.md] to create the docker-compose.yml file.