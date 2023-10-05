![GitHub issues](https://img.shields.io/github/issues/leandrosardi/my-ruby-deployer) ![GitHub](https://img.shields.io/github/license/leandrosardi/my-ruby-deployer) ![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/leandrosardi/my-ruby-deployer) ![GitHub last commit](https://img.shields.io/github/last-commit/leandrosardi/my-ruby-deployer)

![logo](logo.png)

# My Ruby Deployer

**My Ruby Deployer** (or just **Deployer**) automates what you already know how to do manually, but in a repeatable, scalable fashion. There is no magic here!

```ruby
# deploy new version
BlackStack::Deployer.deploy()
```

## For Any Language

**Deployer** has been written in Ruby, but it can easily be used to deploy any language.

**Outline**

1. [Installation](#1-installation)
2. [Getting Started](#2-getting-started)
3. [Built-In Routines](#3-built-in-routines)
4. [Default Routines](#4-default-routines)
5. [Custom Routines](#5-custom-routines)
6. [Database Updates](#6-database-updates)
7. [Reprocessing](#7-reprocessing)
8. [Advanced Features](#8-advanced-features)
9. [Dependencies](#9-dependencies)

## 1. Installation

```bash 
gem install my-ruby-deployer
```

## 2. Getting Started

**Step 1:** Require **my-ruby-deployer**.

```ruby
require 'my-ruby-deployer'
```

**Step 2:** Define a Deployment Routine.

```ruby
# routines
BlackStack::Deployer::add_routine({
  :name => 'upgrade-packages',
  :commands => [
    { 
        :command => '
          apt update
          apt upgrade
        ', 
    },
  ],
});
```

Since the deployment must run fully automated, you want the commands don't interact with the user.

```ruby
# routines
BlackStack::Deployer::add_routine({
  :name => 'upgrade-packages',
  :commands => [
    { 
        :command => '
          apt -y update
          apt -y upgrade
        ', 
    },
  ],
});
```

As a good practice, you may want to log the output of each command:

```ruby
# routines
BlackStack::Deployer::add_routine({
  :name => 'upgrade-packages',
  :commands => [
    { 
        :command => '
            echo "Upgrading packages..." >> /tmp/upgrade-packages.log 2>&1
            apt -y update >> /tmp/upgrade-packages.log 2>&1
            echo "Upgrading packages..." >> /tmp/upgrade-packages.log 2>&1
            apt -y upgrade >> /tmp/upgrade-packages.log 2>&1
        ', 
    },
  ],
});
```

**Step 3:** Define your fleet of computers (nodes).

```ruby
BlackStack::Deployer::add_nodes([{
    # use this command to connect from terminal: ssh -i "plank.pem" ubuntu@ec2-34-234-83-88.compute-1.amazonaws.com
    :name => 'node01',
    :net_remote_ip => '127.0.0.1',  
    :ssh_username => 'leandro',
    :ssh_password => 'foo',
    :ssh_port => 22,
}, {
  ...
}])
```

**Step 3:** Run a deployment for all your nodes

```ruby
BlackStack::Deployer.deploy('upgrade-packages')
```

## 3. Built-In Routines

The only name that you can't assign to a routine `'reboot'`, because it is reserved as a native routine of **my-ruby-deployer**.

**Example:**

```ruby
# routines
BlackStack::Deployer::add_routine({
  :name => 'change-hostname',
  :commands => [
    { 
        :command => '
            echo "%name%" > /etc/hostname
        ', 
    }, { 
        :command => :reboot
    },
  ],
});
```

## 4. Default Routines

**Step 1:** Define what is the routine you want to run on each node.

```ruby
BlackStack::Deployer::add_nodes([{
    # use this command to connect from terminal: ssh -i "plank.pem" ubuntu@ec2-34-234-83-88.compute-1.amazonaws.com
    :name => 'node01',
    :net_remote_ip => '127.0.0.1',  
    :ssh_username => 'leandro',
    :ssh_password => 'foo',
    :ssh_port => 22,
    # setup a default routine
    :deployment_routine => 'upgrade-packages',
}, {
  ...
}])
```

**Step 2:** Run a deployment for all your nodes

```ruby
BlackStack::Deployer.deploy # it will use the default routine of each node
```

## 5. Custom Routines

If you want to run another routine for a node, you can do it.

```ruby
BlackStack::Deployer.run_routine(node_name, routine_name)
```

## 6. Database Updates

This feature works with any RDBMS supported by [Sequel](https://sequel.jeremyevans.net/).

Running database updates consists in:

1. creating the schema of the database,
(tables, indexes, keys, triggers, store procedures, etc.);

2. insert seed rows on the tables; and

3. run updates for both types: DDL and DML.

**Step 1:** Connect the database

```ruby
# DB ACCESS - KEEP IT SECRET
BlackStack::Deployer::DB::connect_new_db('your Sequel connection string here')
# => DB
```

Reference: [Opening Databases](https://sequel.jeremyevans.net/rdoc/files/doc/opening_databases_rdoc.html)


**Step 2:** Define the folder where you host all your `.sql` files.

```ruby
BlackStack::Deployer::DB::set_folder ('~/code/myrpa/sql');
# => true
```

**Step 3:** Add some files in your `sql` folder.

This command,

```bash
cd ~/code/myrpa/sql
ls
```

may show something like this:

```
20220525.1.transactions.sql
20220525.2.sentences.sql
20220527.1.transactions.sql
```

**Specifications:**

1. The filenames matching with `/\.transactions\.sql$/` processes each block delimited by `BEGIN;` / `COMMIT;` lines. Block by block.

2. The filnames matching with `/\.sentences\.sql$/` will split the content by `/;/`, and will process sentence by sentence.

If a filename doesn't match with neither `/\.transactions\.sql$/` nor `/\.sentences\.sql$/` it will be assume it is a file of **sentences** by default. 

As a final note, we recommend you start each filename with something like 'YYYYMMDD.N.' in order the sort them by the files creation time, which use to be the same order you want the files be processed.

**Step 4:** Process the `.sql` files.

```ruby
BlackStack::Deployer::DB::deploy();
# => true
```

Files will be sorted by name, and processed following such an order.

## 7. Reprocessing

It is a good practice that any `.sql` file can be reprocessed without raising any exception.

**Example 1:** The script below, with the `IF NOT EXISTS` declaration, will attempt to create a table, and it won't raise any exception of the table already exists.

```sql
-- possible countries assigned to a user.
CREATE TABLE IF NOT EXISTS country(
	id uuid NOT NULL PRIMARY KEY,
	code char(500) NOT NULL,
	name char(500) NOT NULL
);
```

**Example 2:** The script below, with the `ON CONFLICT DO NOTHING` declaration, will attempt to insert a record, and it won't raise any exception of the `id` already exists.

```sql
INSERT INTO country (id, code, name) 
VALUES ('1fde0820-ae46-4687-ab4b-d8196f6e5bd0', 'ar', 'Argentina') ON CONFLICT DO NOTHING;
```

## 8. Advanced Features

There are some advanced features that make **my-ruby-deployer** more versatile.

### 8.1. Requesting node reboot 

You can request node reboot as part of a routine. 

```ruby
# setup deploying rutines for different kind of servers.
BlackStack::Deployer::add_routines([{
  :name => 'change-server-name',
  :commands => [
    { :command => "echo 'dbsrv1' > /etc/hostname" },
    { :command => :reboot },
  ],
}]);
```

### 8.2. Pass routine parameters

Your can define parameters parameters between `%` chars, as is shown in the code below.

```ruby
# setup deploying rutines for different kind of servers.
BlackStack::Deployer::add_routines([{
  :name => 'change-server-name',
  :commands => [
    { :command => "echo '%hostname%' > /etc/hostname" },
    { :command => :reboot },
  ],
}]);
```

The value to assign will be taken from the hash descriptor of the node.

```ruby
BlackStack::Deployer::add_nodes([{
  :name => 'node1',
  :net_remote_ip => 'db.mydomain.com', 
  :ssh_username => 'username', 
  :ssh_password => 'password', 
  :deployment_profile => 'db-node',
  :hostname => 'dbsrv',
}])
```

### 8.3. Calling sub-routines

You can request the execution of a routine as part of a bigger routine. 

```ruby
# setup deploying rutines for different kind of servers.
BlackStack::Deployer::add_routines([{
  :name => 'installation',
  :commands => [
    { :command => :'change-server-name' },
    { :command => :reboot },
  ],
}]);
```

### 8.4. Resuming database deploying from last checkpoint

Usually, the first files in the `sql` folder are regrding the creation of the schema and the seed records.

As long as you work on your software, more `.sql` files will be added, but you don't want to process all the files from the begining each time you have to deploy an update.

Instead, you can choose the last file processed in order to resume the update from that point.

```ruby
BlackStack::Deployer::DB::deploy('20220527.1.transactions.sql');
# => true
```

You can get **my-ruby-deployer** remember the last file processed by adding the line below.

```ruby
BlackStack::Deployer::DB::enable_checkpoints(true);
# => true
```

## 9. Dependencies

**Deployer** uses

2. [BlackStack Nodes](https://github.com/leandrosardi/blackstack-nodes/) for connecting; 
2. [pg](https://rubygems.org/gems/pg/) for connecting PostgreSQL database; 
3. [Sequel](https://github.com/jeremyevans/sequel) for simplifying some database tasks;
4. [Net::SSH](https://github.com/net-ssh/net-ssh) for connecting Linux servers via SSH;

The logo has been taken from [here](https://www.shareicon.net/space-exploration-transport-rocket-ship-rocket-space-ship-rocket-silhouette-rocket-ship-launch-669455).

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the last [ruby gem](https://rubygems.org/gems/simple_command_line_parser). 

## Authors

* **Leandro Daniel Sardi** - *Initial work* - [LeandroSardi](https://github.com/leandrosardi)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Further Work

Nothing yet.