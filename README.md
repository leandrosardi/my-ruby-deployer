![logo](logo.png)

# BlackStack Deployer

**BlackStack Deployer** automates what you already know how to do manually, but in a repeatable, scalable fashion. There is no magic here!

```ruby
# deploy new version
BlackStack::Deployer.deploy()
```

## For Any Language

**BlackStack Deployer** has been written in Ruby, but it can easily be used to deploy any language.

## Outline

- [1. Getting Started](#1-getting-started)
- [2. Adding Validations](#2-adding-validations)
- [3. Defining Node Profiles](#3-defining-node-profiles)
- [4. Running Database Updates](#4-running-database-updates)
- [5. Reprocessing Database Updates](#5-reprocessing-database-updates)
- [6. Advanced Features](#6-advanced-features)
	- [6.1. Requesting node reboot](#61-requesting-node-reboot)
	- [6.2. Pass routine parameters](#62-pass-routine-parameters)
	- [6.3. Calling sub-routines](#63-calling-sub-routines)
	- [6.4. Resuming database deploying from last checkpoint](#64-resuming-database-deploying-from-last-checkpoint)
	- [6.5. Running Commands with `sudo` rights](#65-running-commands-with-sudo-rights)
  - [6.6. Showing Commands Output](#66-showing-commands-output)
  - [6.7. Running Commands in Background](#67-running-commands-in-background)
  - [6.8. Checking Command Code](#68-checking-command-code)

- [7. Dependencies](#7-dependencies)

## 1. Getting Started

**Step 1:** Install BlackStack Deployer.

```bash 
gem install blackstack-deployer
```

**Step 2:** Add the computers (nodes) where you want to run deployments.

**Important:** The **user** must be a sudoer. 

```ruby
require 'blackstack-deployer'

# setup nodes
BBlackStack::Deployer::set_nodes([{
  :net_remote_ip => 's1.mydomain.com', 
  :ssh_username => 'username', 
  :ssh_password => 'password', 
}, { 
  :net_remote_ip => 's2.mydomain.com', 
  :ssh_username => 'username', 
  :ssh_password => 'password', 
}])
```

Instead of defining the `ssh_username` and `ssh_password`, you can setup either `.pem` or `.ppk` private key files.

```ruby
BBlackStack::Deployer::add_node({
  :name => 'node1',
  :net_remote_ip => 'db.mydomain.com', 
  :ssh_username => 'username',
  :ssh_private_key_file => '~/certs/db.pem', 
})
``` 

**Step 3:** Setup deployment routines.

```ruby
# setup deploying rutines
BBlackStack::Deployer::set_routines([{
  :name => 'pull-source-code',
  :commands => [
    { :command => 'cd ~/code/myrpa' },
    { :command => 'git fetch --all' },
    { :command => 'git reset --hard origin/main' },
  ],
}, {
  :name => 'restart-rpa',
  :commands => [
    { :command => 'pkill xterm' },
    { :command => 'xterm -e bash -c "cd ~/code/myrpa;./rpa.rb;bash"' },
  ],
}]);
```

**Step 4:** Run a deployment routine

```ruby
BBlackStack::Deployer::run('node1', 'pull-source-code');
# => true
```

As a final note: the only name that you can't assign to a routine `'reboot'`, because it is reserved as a native routine of **blackstack-deployer**.

## 2. Adding Validations

You can validate the output of each command with an array of regular experessions (`:matches`).

You can also look for a list of well known error messages, listed in the `:nomatches` key.

```ruby
# setup deploying rutines for different kind of servers.
BBlackStack::Deployer::add_routine({
    # download the latest version of source code
    :name => 'restart-webserver',
    # run additional bash commands, and validate outputs.
    # 
    # :command is a string with the command to run.
    # :matches is either a regular expression or an array of regular experessions. The command output must match with all of them.
    # :nomatches is either a regular expression or an array of regular experessions. The command output must dis-match with all of them.
    # 
    :commands => [
      { :command => 'cd ~/code/mywebserver' },
      { 
        :command => 'ruby ./webserver.rb --restart', 
        :matches => /Restarted Successfully/, 
        :nomatches => [
          { :nomatch => /Permission Denied/, :error_description => 'no grants' },
          { :nomatch => /Command not found/, :error_description => 'kill command is not installed' },
        ]
      },
    ],
});
```

## 3. Defining Node Profiles

**Step 1:** Define the routine that each node should run for deploying.

```ruby
BBlackStack::Deployer::set_nodes([{
  :name=>'node1',
  :net_remote_ip => 's1.mydomain.com', 
  :ssh_username => 'username', 
  :ssh_password => 'password', 
  :deployment_routine => 'rpa-node',
}, { 
  :name=>'node2',
  :net_remote_ip => 's2.mydomain.com', 
  :ssh_username => 'username', 
  :ssh_password => 'password', 
  :deployment_routine => 'rpa-node'
}])
```

**Step 2:** Run deployment for all nodes.

```ruby
BBlackStack::Deployer::deploy()
```

## 4. Running Database Updates

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

## 5. Reprocessing Database Updates

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

## 6. Advanced Features

There are some advanced features that make **blackstack-deployer** more versatile.

### 6.1. Requesting node reboot 

You can request node reboot as part of a routine. 

```ruby
# setup deploying rutines for different kind of servers.
BBlackStack::Deployer::add_routines([{
  :name => 'change-server-name',
  :commands => [
    { :command => "echo 'dbsrv1' > /etc/hostname" },
    { :command => :reboot },
  ],
}]);
```

### 6.2. Pass routine parameters

Your can define parameters parameters between `%` chars, as is shown in the code below.

```ruby
# setup deploying rutines for different kind of servers.
BBlackStack::Deployer::add_routines([{
  :name => 'change-server-name',
  :commands => [
    { :command => "echo '%hostname%' > /etc/hostname" },
    { :command => :reboot },
  ],
}]);
```

The value to assign will be taken from the hash descriptor of the node.

```ruby
BBlackStack::Deployer::add_nodes([{
  :name => 'node1',
  :net_remote_ip => 'db.mydomain.com', 
  :ssh_username => 'username', 
  :ssh_password => 'password', 
  :deployment_profile => 'db-node',
  :hostname => 'dbsrv',
}])
```

### 6.3. Calling sub-routines

You can request the execution of a routine as part of a bigger routine. 

```ruby
# setup deploying rutines for different kind of servers.
BBlackStack::Deployer::add_routines([{
  :name => 'installation',
  :commands => [
    { :command => :change-server-name },
    { :command => :reboot },
  ],
}]);
```

### 6.4. Resuming database deploying from last checkpoint

Usually, the first files in the `sql` folder are regrding the creation of the schema and the seed records.

As long as you work on your software, more `.sql` files will be added, but you don't want to process all the files from the begining each time you have to deploy an update.

Instead, you can choose the last file processed in order to resume the update from that point.

```ruby
BlackStack::Deployer::DB::deploy('20220527.1.transactions.sql');
# => true
```

You can get **blackstack-deployer** remember the last file processed by adding the line below.

```ruby
BlackStack::Deployer::DB::enable_checkpoints(true);
# => true
```

### 6.5. Running Commands with `sudo` rights

You can use the `:sudo` parameter to run a command with `sudo` rights.

**Example:** The routine below is aimed to stop your webserver by killing any `puma` and any `ruby` processes.

```ruby
# setup deploying rutines
BlackStack::Deployer::add_routine({
  :name => 'stop-mysaas',
    :commands => [
      { 
        # kill any processes line matching with /puma/, except the `grep` command that I am using to find such processes.
        #
        # kill any processes line matching with /ruby/, except the process where this command is running, and except the `grep` command that I am using to find such processes.
        #
        # reference: https://superuser.com/questions/49114/kill-all-processes-of-a-user-except-a-few-in-linux
        :command => "
          ps ax | grep puma | grep -v grep | cut -b3-7 | xargs -t kill;
          ps ax | grep ruby | grep -v grep | grep -v #{Process.pid} | cut -b3-7 | xargs -t kill; 
        ",
      },  
  ],
});
```

If you execute `BlackStack::Deployer::routines[0].commands[0].code`, you will see this script:

```bash
ps ax | grep puma | grep -v grep | cut -b3-7 | xargs -t kill;
ps ax | grep ruby | grep -v grep | grep -v <id of running process> | cut -b3-7 | xargs -t kill; 
```

Probably, such a routine will fail because of a permissions matter.

To avoid this problem, you can add the `:sudo` parameter.

```ruby
# setup deploying rutines
BlackStack::Deployer::add_routine({
  :name => 'stop-mysaas',
    :commands => [
      { 
        :command => "
          ps ax | grep puma | grep -v grep | cut -b3-7 | xargs -t kill;
          ps ax | grep ruby | grep -v grep | grep -v #{Process.pid} | cut -b3-7 | xargs -t kill; 
        ",
        :sudo => true,
      },  
  ],
});
```

If you execute `BlackStack::Deployer::routines[0].commands[0].code`, you will see this script:

```bash
echo '<root password here>' | sudo -S su root -c '
  ps ax | grep puma | grep -v grep | cut -b3-7 | xargs -t kill;
  ps ax | grep ruby | grep -v grep | grep -v <id of running process> | cut -b3-7 | xargs -t kill;
' 
```

### 6.6. Showing Commands Output

You can check if a command ran successfully using the `:matches` and `:nomatches` parameters.

If the command fails with any error that you didn't incldude there, the command will report that finished successfully even if it didn't.

Add the line below to get your deployment process showing the output of each command.

```ruby
BlackStack::Deployer.set_show_output(true)
```

### 6.7. Running Commands in Background

The `:background` parameter is used to run a command and don't wait it to finish.

**Example:** The routine below starts a Ruby-Sinatra webserver.

```ruby
BlackStack::Deployer::add_routine({
  :name => 'start-mysaas',
  :commands => [
    { 
      :command => "
        source /home/%ssh_username%/.rvm/scripts/rvm; rvm install 3.1.2; rvm --default use 3.1.2;
        cd /home/%ssh_username%/code/mysaas;
        export RUBYLIB=/home/%ssh_username%/code/mysaas;
        nohup ruby app.rb port=%web_port%;
      ",
    }, 
  ], 
});
```

If you execute `BlackStack::Deployer::routines[0].commands[0].code`, you will see this script:

```bash
source /home/%ssh_username%/.rvm/scripts/rvm; rvm install 3.1.2; rvm --default use 3.1.2;
cd /home/%ssh_username%/code/mysaas;
export RUBYLIB=/home/%ssh_username%/code/mysaas;
nohup ruby app.rb port=%web_port%;
```

Such a script will hang the terminal, with the webserver listening.

The solution is using the `:background` parameter as is shown in the code below:

```ruby
BlackStack::Deployer::add_routine({
  :name => 'start-mysaas',
  :commands => [
    { 
      :command => "
        source /home/%ssh_username%/.rvm/scripts/rvm; rvm install 3.1.2; rvm --default use 3.1.2;
        cd /home/%ssh_username%/code/mysaas;
        export RUBYLIB=/home/%ssh_username%/code/mysaas;
        nohup ruby app.rb port=%web_port%;
      ",
      :background => true,
    }, 
  ], 
});
```

The same script will be modified to run each line in background.
If you execute `BlackStack::Deployer::routines[0].commands[0].code`, you will see this script:

```bash
source /home/%ssh_username%/.rvm/scripts/rvm; rvm install 3.1.2; rvm --default use 3.1.2 > /dev/null 2>&1;
cd /home/%ssh_username%/code/mysaas > /dev/null 2>&1;
export RUBYLIB=/home/%ssh_username%/code/mysaas > /dev/null 2>&1;
nohup ruby app.rb port=%web_port% > /dev/null 2>&1 &
```

**Note:**

1. On each line, except the last one, the last `;` is replaced by ` > /dev/null 2>&1;`.

2. In the last line, the last `;` is replaced by ` > /dev/null 2>&1 &`.

3. Each line in the code of the `:command` parameter must finish with `;`. No comments allowed.

4. If the `:show_output` parameter is activated, the `:background` parameter will be ignored.

### 6.8. Checking Command Code

If you want to know exactly how a command will be exectued after apply the modification regarding the parmaeters listed above, just run this line of code:

```ruby
BlackStack::Deployer::routines[0].commands[0].code
```

## 7. Dependencies

**BlackStack Deployer** uses

2. [BlackStack Nodes](https://rubygems.org/gems/blackstack-nodes/) for connecting; 
2. [pg](https://rubygems.org/gems/pg/) for connecting PostgreSQL database; 
3. [Sequel](https://github.com/jeremyevans/sequel) for simplifying some database tasks;
4. [Net::SSH](https://github.com/net-ssh/net-ssh) for connecting Linux servers via SSH;

The logo has been taken from [here](https://www.shareicon.net/space-exploration-transport-rocket-ship-rocket-space-ship-rocket-silhouette-rocket-ship-launch-669455).


