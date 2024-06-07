# NGINX
_nginx_ is an open-source software for web serving, reverse proxying, caching and more. It was initially wrote to solve the [C10K problem](https://en.wikipedia.org/wiki/C10k_problem), means, optimize network sockets to handle a large amount of clients at the same time. Basically it acts as a _reverse proxy_, an intermediate layer between the browser and the server, to handle the incoming requests. Some benefits are related to load balancing, memory caching, encryption and security. In general it results in improved performances.

## Basic related concepts
### workers
A _worker_ in nginx is a separate process which handles incoming connections and processes the requests. Each worker can handle multiple connection, therefore it can process multiple requests simultaneously.

### HTTP & HTTPS
- *HTTP* - Hyper-Text Transfer Protocol. The informations are NOT encrypted.  
- *HTTPS* - Secure Hyper-Text Transfer Protocol. The informations are encrypted using SSL/TLS protocols.  

### SSL & TLS
- *SSL* - Secure Socket Layer  
- *TLS* - Transport Layer Security  
- *openssl* - is an implementation of those protocols, therefore used to generate a key and a certificate for:
	- Trust validation between client-server. Basically the server asks to the requesting computer to identify itself, and after this the data will be exchanged (also called handshake).  
	- Connection encryption. The server owns a public key which is shared with anyone who wants to connect, and a private one, used to encrypt/decrypt the message (see asymmetric encryption).  
For the project we have to use either _TLS1.2_ or _TLS1.3_. Check [here](https://www.a10networks.com/glossary/key-differences-between-tls-1-2-and-tls-1-3/) the difference between the two versions of the protocol. If you want to check each step of TLS check this nice [visualizer](https://tls13.xargs.org/).

### CGI & FastCGI
_Common Gateway Interface_ is a protocol which describes how a web server communicates with an external program (called CGI script), to process the request of a dynamic content. In other words, how _data sharing_ has to be done, while before there were compatibility issues.

| Pros                                                                 | Cons                                                                              |
|----------------------------------------------------------------------|-----------------------------------------------------------------------------------|
| No garbage collection, because the memory reserved for the process created is automatically freed when it ends. | Since each request results in a new process, it could have performance issues with high traffic. |
| Portable, thanks to the possibility to use multiple and different programming languages without any effort. | Vulnerability.                                                                    |

_FastCGI_ is the evolution of CGI. Instead of creating a new process for each request, there is a persistent process pool which remains alive, resulting in better performances. Here [PHP-FPM](../wordpress/README.md/#php-fpm) comes into play.

### URI & URL (& URN)
- *URI* (Uniform Resources Identifier): identifier for any type of resource, not only on internet.  
_Examples_: urn:isbn:978-3-16-148410-0, \`mailto:info@example.com\`, tel:+1-212-555-1212
- *URL* (Uniform Resources Locator): specific type of URI used to locate resources on internet.
_Examples_: \`https://www.example.com/index.html\`, \`ftp://ftp.example.com/files/document.pdf\`
- *URN* (Uniform Resources Name): persistent and location-indipendent identifier.  

### sockets
A socket is a strategy for communication between client-server. It can be defined as an endpoint for communication. Given a communication between 2 processes over a network, each of them will have its own socket. The server waits and listen to a port, the client will send a request, the server accepts it and the connection is established. Identity of a socket: [IP address]:[port number].



## Configuration
_/etc/nginx/nginx.conf_ contains the _http_ and _events_ context, which are inside the _main_ context. Inside _http_ we will place the _server_ blocks, in which take place one or more _location_ blocks. Let's note that at the end of the _http_ block inside this conf file the are those statements, which will be inside the _http_ scope:
- _include /etc/nginx/conf.d/*.conf;_
- _include /etc/nginx/sites-enabled/*;_

Therefore, by adding a file to those folder, would add our custom configurations.  
I choose to add my configuration to _sites-available_ and create a symlink to _sites-enabled_. I also had to remove the symlink to _default_ configuration in _sites-enabled_, like [this](https://www.linode.com/docs/guides/how-to-enable-disable-website/) page explains.  

**NOTE**: Pay attention that there are some strange facts about _/etc/nginx/sites-enabled/_ and _/etc/nginx/sites-available/_ in Debian, which you can eventually explore in [here](https://serverfault.com/questions/1075019/nginx-on-debian-buster-the-right-way-to-handle-config-files) and [here](https://stackoverflow.com/questions/41303885/nginx-do-i-really-need-sites-available-and-sites-enabled-folders).

### Nginx configuration terms
- *_Context_*: delimited by curly brackets `{...}`. By nesting them, configurations can be inherited.
- *_Directive_*: the context is made of rule, the directives. They can be used only in the context that they were designed for, otherwise an error is returned.

Main contexts:
- _main_: it's a kind of global scope. Common use: number of workers, file to save the main nginx pid, error file.
- _events_: connection handling at a general level.
- _http_: used for web-serv or rev-proxy. It's a sibiling of events context.
- _server_: nested in HTTP, can be declared multiple times. The type of this context determines which algorithm is choosen by nginx to handle request.
- _location_: nested in server contexts, and in themselves. Used to define endpoints.

## How nginx processes a request
In general, nginx try to find the best match of a request:
### [ A ] - Choose the right server block
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

### [ B ] - Choose the right location block
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

### [ C ] - Internal location block redirection
Those directives could influence the behavior after a location block is choosen.
- index
- try_files
- rewrite
- error_page

Check this tutorial about [nginx and Location block selection algorithm](https://www.digitalocean.com/community/tutorials/understanding-nginx-server-and-location-block-selection-algorithms) explained, means, how nginx processes a request how chooses the right configuration block.

## nginx & FastCGI
Nginx can proxy (proxying means passing) the client request to be handled by [fastCGI](./README.md/#cgi--fastcgi). In our use case we have to do it, because nginx can't process PHP (unlike Apache), therefore it has to pass the request to a program which can do it, which is out _PHP-FPM_. To do this it uses the `fastcgi_pass` directive, which sends the request to the wordpress container. In addition, we have to send other information to PHP to process the request. Check this [tutorial](https://www.digitalocean.com/community/tutorials/understanding-and-implementing-fastcgi-proxying-in-nginx) to have a complete explaination about it.

The following is an example of configuration I did. The parameters in the square brackets `[...]` can differ based on your decisions.

```nginx
server {
	listen 443 ssl default_server;
	server_name [domain-name];

	ssl_certificate_key /etc/ssl/private/[domain-name].key;
	ssl_certificate /etc/ssl/certs/[domain-name].crt;
	ssl_protocols TLSv1.3;
	ssl_ciphers HIGH:!aNULL:!MD5;

	root /var/www/html/[domain-name]/public_html/;
	index index.php;

	access_log /var/log/nginx/[domain-name]-access.log;
	error_log /var/log/nginx/[domain-name]-error.log;

	location / {
		try_files $uri $uri/ /index.php?$args =404;
	}

	location ~ \.php$ {
		include fastcgi_params;
		fastcgi_pass [network-name]:9000;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		fastcgi_param QUERY_STRING $query_string;
	}
}
```

Given this file, if we type _https://[domain-name]_ in the VM, nginx performs those steps:
1) SSL/TLS.
	- Handshake.
	- Certificate validation.
2) Request routing. 
	- The request is taken by `location /` and use the `try_files` directive.
	- `try_files` tries _$uri_, _$uri/_ and if they don't match fallbacks to _/index.php?$args_.
	- The request is taken then by `location ~ \.php$` block, which forwards the request to PHP.

## Quick reference
- `service nginx status`
- `nginx -s [stop/quit/reload/reopen]`
- `nginx -t` checks status of config file
- `nginx -g daemon off` run the nginx in the background

## Useful resources
- [Nginx crash course](https://www.youtube.com/watch?v=7VAI73roXaY&t=686s) I used to learn the basics.  
- [Round-robin algorithm](https://en.wikipedia.org/wiki/Round-robin_scheduling), the defualt used to proxy the traffic to servers.
- [Nginx Configuration](https://www.nginx.com/resources/wiki/start/topics/examples/phpfcgi/) along with FastCGI and PHP-fpm. 
- [Non-profit SSL certificate](https://letsencrypt.org/) to enable https.
- [Useful randomz cheatsheet](https://github.com/christianlempa/cheat-sheets)
