# NGINX
The subject requires a container with NGINX with TLSv1.2 or 1.3 only.

## What is NGINX
Open-source software for web serving, reverse proxying, caching and more. It was initially wrote to solve the [C10K problem](https://en.wikipedia.org/wiki/C10k_problem), means, optimize network sockets to handle a large amount of clients at the same time.
Basically it acts as a _reverse proxy_, an intermediate layer between the browser and the server, to handle the incoming requests. Some benefits are related to load balancing, memory caching, encryption and security. In general it results in improved performances.

## Sockets
Strategy for communication between client-server. It can be defined as an endpoint for communication. Given a communication between 2 processes over a network, each of them will have its own socket. The server waits and listen to a port, the client will ask a request, the server accepts it and the connection is established.
Identity of a socket: [IP address]:[port number]

## TLS
Transport Layer Security is the successor of SSL (Secure Socket Layer) is a security protocol to establish a secure communication between two system on a network. The connection is established by using public key encryption. *OpenSSL* is an implementation SSL/TLS protocols.

## Configuration file
*nginx.conf* location:
- /etc/nginx/nginx.conf (usually here)
- /usr/local/nginx/conf
- /usr/local/etc/nginx



## Terminology
_Daemon process_: a process which runs in the background.

## Reference
`nginx -s [stop/quit/reload/reopen]`
`nginx -t` checks status of config file

`service nginx status`
`systemctl status nginx`
