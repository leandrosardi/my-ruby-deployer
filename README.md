# Pampa Deployer

**Pampa Deployer** is a simple library  for building automated deployment scripts of 

1. [Pampa Workers](https://github.com/leandrosardi/pampa),
2. [Pampa Dispatchers](https://github.com/leandrosardi/pampa_dispatchers), and
3. [Tempora Webservers](https://github.com/leandrosardi/tempora) (private servers).

Once installed, Capistrano gives you a cap tool to perform your deployments from the comfort of your command line.

# Installation

```cmd
gem install pampa_deployer
```

# Features

**Pampa Deployer** automates what you already know how to do manually, but in a repeatable, scalable fashion. There is no magic here!

Here's what makes Capistrano great:

**Strong conventions**
Capistrano defines a standard deployment process that all Capistrano-enabled projects follow by default. You don't have to decide how to structure your scripts, where deployed files should be placed on the server, or how to perform common tasks: Capistrano has done this work for you.

**Multiple stages**
Define your deployment once, and then easily parameterize it for multiple stages (environments), e.g. qa, staging, and production. No copy-and-paste necessary: you only need to specify what is different for each stage, like IP addresses.

**Parallel execution**
Deploying to a fleet of app servers? Capistrano can run each deployment task concurrently across those servers and uses connection pooling for speed.

**Server roles**
Your application may need many different types of servers: a database server, an app server, two web servers, and a job queue work server, for example. Capistrano lets you tag each server with one or more roles, so you can control what tasks are executed where.

**REST-API based**
Everything in Capistrano comes down to running SSH commands on remote servers. On the one hand, that makes Capistrano simple. On the other hand, if you aren't comfortable SSH-ing into a Linux box and doing stuff on the command-line, then Capistrano is probably not for you.

## Sequences

**Developer**
1. push new version
	- source code
	- sequel migration
	- gems
2. push deploy request via access point

**Kepler (central) - shm.rb**
1. poll deploy requests
2. pull new deploy request
3. git fetch --all
4. git reset --hard origin/#{brach}
5. update secret files
6. perform sequel migrations
7. perform bundler update
8. restart puma
9. restart processes
10. call a.point to update node version
11. allow other nodes to deploy

**Eulers (divisions)**
1. poll ALLOWED deploy requests
2. pull new ALLOWED deploy request
4. perform bundler update
5. restart puma
6. call a.point to update version on division

**Newtons (workers)**
1. poll deploy requests
2. pull new deploy request
3. git fetch --all
4. git reset --hard origin/#{brach}
5. update secret files
6. perform sequel migrations
7. perform bundler update
8. restart workers
9. call a.point to update node version

**Copernico (dispatchers, jobs, planners)**
1. poll ALLOWED deploy requests
2. pull new ALLOWED deploy request
4. perform bundler update
5. restart processes
6. call a.point to update version on division