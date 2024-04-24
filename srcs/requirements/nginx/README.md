# NGINX
The subject requires a container with NGINX with TLSv1.2 or 1.3 only.

## What is NGINX
Open-source software for web serving, reverse proxying, caching and more. It was initially wrote to solve the [C10K problem](https://en.wikipedia.org/wiki/C10k_problem), means, optimize network sockets to handle a large amount of clients at the same time.
Basically it acts as a _reverse proxy_, an intermediate layer between the browser and the server, to handle the incoming requests. Some benefits are related to load balancing, memory caching, encryption and security. In general it results in improved performances.

## HTTP & HTTPS
*HTTP* - Hyper-Text Transfer Protocol. The informations are NOT encrypted.  
*HTTPS* - Secure Hyper-Text Transfer Protocol. The informations are encrypted using SSL/TLS protocols.  

## SSL & TLS
*SSL* - Secure Socket Layer  
*TLS* - Transport Layer Security  
*openssl* is an implementation of those protocols, therefore used to generate a key and a certificate  

Jobs:
- Trust validation between client-server. Basically the server asks to the requesting computer to identify itself, and after this the data will be exchanged.  
- Connection encryption. The server owns a public key which is shared with anyone who wants to connect, and a private one, used to encrypt/decrypt the message (see asymmetric encryption).  

## Configuration file
*nginx.conf* location:
- /etc/nginx/nginx.conf (usually here)
- /usr/local/nginx/conf
- /usr/local/etc/nginx

*_Context_*: delimited by curly brackets `{...}`. By nesting them, configurations can be inherited.
*_Directive_*: the context is made of rule, the directives. They can be used only in the context that they were designed for, otherwise an error is returned.

Main contexts:  
- _main_: it's a kind of global scope. Common use: number of workers, file to save the main nginx pid, error file.
- _events_: connection handling at a general level.
- _HTTP_: used for web-serv or rev-proxy. It's a sibiling of events context.
- _server_: nested in HTTP, can be declared multiple times. The type of this context determines which algorithm is choosen by nginx to handle request.
- _location_: nested in server contexts, and in themselves. Used to define endpoints.

## Terminology
_Daemon process_: a process which runs in the background.  
_Load balancing_: the process to make efficient the distribution of tasks, given the resources (like a big amount of requests directed to a group of server).s  
_Sockets_: strategy for communication between client-server. It can be defined as an endpoint for communication. Given a communication between 2 processes over a network, each of them will have its own socket. The server waits and listen to a port, the client will send a request, the server accepts it and the connection is established. Identity of a socket: [IP address]:[port number].

## Reference
`nginx -s [stop/quit/reload/reopen]`
`nginx -t` checks status of config file

`service nginx status`
`systemctl status nginx`

## Useful resources
[Bginx crash course](https://www.youtube.com/watch?v=7VAI73roXaY&t=686s) I used to learn the basics.
[Round-robin algorithm](https://en.wikipedia.org/wiki/Round-robin_scheduling), the defualt used to proxy the traffic to servers.  
[Useful cheatsheet](https://github.com/christianlempa/cheat-sheets)