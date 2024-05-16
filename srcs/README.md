# docker compose
To learn about docker compose I first tried to compose the architecture required by the subject, using the official docker image for each required service. I follow the built explained in [this tutorial](https://bobcares.com/blog/docker-compose-nginx-php-fpm-mysql-wordpress/) and after verifying its functionality, I played around it, making some adjustments and changed some paramteres. 

A very important reference I used to get the syntax and learn some concepts is the [docker compose sepcification](https://github.com/compose-spec/compose-spec/blob/master/spec.md).

## How to test if everything is set up correctly
Before play around it, test if the plain infrastructure works. A simple but redundant (because of browser, cache, automatic add of https) way of testing is accessing `http` or `https` at `localhost:[port-you-opened]`. The result of this should be the wordpress installation page. Pay attention that some browser try to autocomplete the _http_ to _https_.  

Another smart way is using _curl_ in the command line with `curl -I localhost:[port-you-opened]`, but read carefully the output. 

## Other experiments
These are some tests and changes that I tried:
- Change `ports` to `expose` (see [ports vs expose](#ports-vs-expose)).
- Get rid of the default network and create a custom one (see [networks](#networks)).
- Move the variables into `.env` files, using `env_file` directive in docker-compose instead of `environment`, but pay attention, read the chapter about [.env](#env).

### ports vs expose
Try another test: exchange `expose` and `port` in wordpress and mariadb, and try to _curl_ them using _localhost_ and the opened port.

Check [here](https://stackoverflow.com/questions/40801772/what-is-the-difference-between-ports-and-expose-in-docker-compose) the difference between the two statements and how to verify it.

### networks
If none of the service has a specified network, a _default network connection_ for that service is created automatically by docker. If every service has a specified network, no default network is created, and they will be in different network, in other words isolated from each other.

To test it you can use `docker network list` to display the networks after compose in both cases. In case no network is specified, you should see a default one, which is not there in case each service has a specified one.

Check paramters by using `docker network inspect [network-name]` and also `docker container inspect [container-name]`. Very important to note, is that when a service is assigned to a network, it has its own randomly generated IP address, which it is not visibile from the other services. But if you carefully inspect the container and network specification, you'll notice that the containers can be identified by that IP Address, and an _alias_ which traduces it for the other services. So for example, nginx needs to know to which address redirect the client's request, and the only way to set in the configuration before startup, is using the alias given to wordpress. Check the documentation, and try to add a different alias to the container network.

## .env
when I started the project I understimated the importantce of maintain some sensitive data (password, usernames) protected by the look of everyone. Simply said, I planned to hide this data right before the evaluation, but a morning I woke up and thought: _"GIT!!!"_ like the mother in [Home Alone](https://en.wikipedia.org/wiki/Home_Alone) when realized that she left Kevin at home.  
The simple problem is, that the sensitive data I was planning to remove right before the evaluation, it was already spreaded in the git repo, so retrieveable by just anyone how knows on how to inspect a previous commit.  
Well, this is learn by doing and also by NOT doing. If you came to this point in time, you can avoid from start using a `.gitignore` file. If not, not everything is lost. You can modify the history by removing the files or folder you don't want, but remember: this has to be the last time you did this stupid thing. Here is a learn project, in the real world would mean losing real money because of you.

Check this articles to get rid of it. There are basically different ways to do it. Here is reported one of the two i used.
- https://stackoverflow.com/questions/307828/how-do-you-fix-a-bad-merge-and-replay-your-good-commits-onto-a-fixed-merge
- https://github.com/newren/git-filter-repo/tree/main
