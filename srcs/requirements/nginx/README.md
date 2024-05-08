# NGINX

## nginx told to a child
// ----- !!!! to complete !!!! ------ //  
// ----- !!!! to complete !!!! ------ //  
// ----- !!!! to complete !!!! ------ //  
// ----- !!!! to complete !!!! ------ //  
// ----- !!!! to complete !!!! ------ //  

## What is NGINX
Open-source software for web serving, reverse proxying, caching and more. It was initially wrote to solve the [C10K problem](https://en.wikipedia.org/wiki/C10k_problem), means, optimize network sockets to handle a large amount of clients at the same time.
Basically it acts as a _reverse proxy_, an intermediate layer between the browser and the server, to handle the incoming requests. Some benefits are related to load balancing, memory caching, encryption and security. In general it results in improved performances.

## HTTP & HTTPS
- *HTTP* - Hyper-Text Transfer Protocol. The informations are NOT encrypted.  
- *HTTPS* - Secure Hyper-Text Transfer Protocol. The informations are encrypted using SSL/TLS protocols.  

## SSL & TLS
- *SSL* - Secure Socket Layer  
- *TLS* - Transport Layer Security  
- *openssl* - is an implementation of those protocols, therefore used to generate a key and a certificate  

Jobs:
- Trust validation between client-server. Basically the server asks to the requesting computer to identify itself, and after this the data will be exchanged.  
- Connection encryption. The server owns a public key which is shared with anyone who wants to connect, and a private one, used to encrypt/decrypt the message (see asymmetric encryption).  

## URI & URL (& URN)
- *URI* (Uniform Resources Identifier): identifier for any type of resource, not only on internet.  
_Examples_: urn:isbn:978-3-16-148410-0, \`mailto:info@example.com\`, tel:+1-212-555-1212
- *URL* (Uniform Resources Locator): specific type of URI used to locate resources on internet.
_Examples_: \`https://www.example.com/index.html\`, \`ftp://ftp.example.com/files/document.pdf\`
- *URN* (Uniform Resources Name): persistent and location-indipendent identifier.  

## Configuration file
Location of the configuration files:
- _/etc/nginx/nginx.conf_: contains the _http_ and _events_ context, which are inside the _main_ context. Inside _http_ we will place the _server_ blocks, in which take place one or more _location_ blocks. Let's note that at the end of the _http_ block inside this conf file the are those statements, which will be inside the _http_ scope:
	- _include /etc/nginx/conf.d/*.conf;_
	- _include /etc/nginx/sites-enabled/*;_
Because of this, we will have to change the whole _nginx.conf_ because it also hold SSL settings, which the subject require to be set in a certain way.

## Configuration terms
- *_Context_*: delimited by curly brackets `{...}`. By nesting them, configurations can be inherited.
- *_Directive_*: the context is made of rule, the directives. They can be used only in the context that they were designed for, otherwise an error is returned.

Main contexts:  
- _main_: it's a kind of global scope. Common use: number of workers, file to save the main nginx pid, error file.
- _events_: connection handling at a general level.
- _http_: used for web-serv or rev-proxy. It's a sibiling of events context.
- _server_: nested in HTTP, can be declared multiple times. The type of this context determines which algorithm is choosen by nginx to handle request.
- _location_: nested in server contexts, and in themselves. Used to define endpoints.

## Other terms
- _Daemon process_: a process which runs in the background.  
- _Load balancing_: the process to make efficient the distribution of tasks, given the resources (like a big amount of requests directed to a group of server).s  
- _Sockets_: strategy for communication between client-server. It can be defined as an endpoint for communication. Given a communication between 2 processes over a network, each of them will have its own socket. The server waits and listen to a port, the client will send a request, the server accepts it and the connection is established. Identity of a socket: [IP address]:[port number].

## How works the nginx request processing
https://www.digitalocean.com/community/tutorials/understanding-nginx-server-and-location-block-selection-algorithms

In general, nginx try to find the best match of a request:
### I - Choose the right server block
1) **Parse the _listen_ directive**
- Translates incomplete listen directives, by using defaults (ex. when listen is not specified, it is added as 0.0.0.0:80).
- Collect a list of server blocks which match the request, based on IP address and port (how is it prioritized?). The port has a higher priority because has to match exactly.
- Only if the matches are multiple, and therefore the selection is ambiguous because those matches share the same level of specificity, nginx parses the server_name.

```nginx
# between those two server block, a request to helloworld.com will match the second block, because it has a higher grade of specificity

server {
	listen 80;				# automatic translated to 0.0.0.0:80
	server_name helloworld.com;
}

server {
	listen 192.168.1.10;	# automatic translated 192.168.1.10:80
}
```
2) **Parse the _server\_name_ directive**
- Exact match to the request.
- Match with wildcard * at the beginning, and THEN at the end.
- match with regex.
- If no match was found, the request is passed to the _default\_server_.

### II - Choose the right location block
The _location_ block processes the URI, which is the part after the domain name, ip address and port.
- Location match: what is checked for the matching.
- Optional modifier: how is checked (can be empty or =, ~ ~*, ^~).

The matching is processed in this order:
- Exact match to the location.
- Longest prefix match (see example in code block).
- Regex.
- Default (aka. location /).

```nginx
# longest prefix match meaning; suppose the request URI is /hello/world/wallpaper.jpg
location /hello {
	# not matched
}

location /hello/world {
	# matched, because matches most char at the beginning of the request URI
}
```

### III - Internal location block redirection
Those directives could influence the behavior after a location block is choosen.
- index
- try_files
- rewrite
- error_page

(nginx and Location block selection algorithm)[https://www.digitalocean.com/community/tutorials/understanding-nginx-server-and-location-block-selection-algorithms] explained, means, how nginx processes a request how chooses the right configuration block.

## Quick reference
- `service nginx status`
- `nginx -s [stop/quit/reload/reopen]`
- `nginx -t` checks status of config file

## Useful resources
[Nginx crash course](https://www.youtube.com/watch?v=7VAI73roXaY&t=686s) I used to learn the basics.
[Round-robin algorithm](https://en.wikipedia.org/wiki/Round-robin_scheduling), the defualt used to proxy the traffic to servers.  
Nginx Configuration with [FastCGI and PHP-fpm](https://www.nginx.com/resources/wiki/start/topics/examples/phpfcgi/). 
[sites-enabled & sites-available](https://serverfault.com/questions/1075019/nginx-on-debian-buster-the-right-way-to-handle-config-files) folders.
Check also [this answer](https://stackoverflow.com/questions/41303885/nginx-do-i-really-need-sites-available-and-sites-enabled-folders) in case of doubt.

[Non-profit SSL certificate](https://letsencrypt.org/) to enable https.


#### to clean ______ !!!!
[Useful cheatsheet](https://github.com/christianlempa/cheat-sheets)