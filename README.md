# Pampa Deployer

**Pampa Deployer** is a Ruby gem for automated software installation and deploying of new versions, along a large pool of computers, with just one line of code.

```ruby
# deploy new version
BlackStack::Deployer.deploy(branch_name)
```

## 1. Getting Started

Install Pampa Deployer

```bash 
gem intall pampa_deployer
```

Write your configuration file up to date.

```ruby
# setup deploying profiles for different kind of servers.
BlackStack::Deployer.set({
  :deploying_profiles => [{
    # this is the name to identify the profile
    :name => 'sinatra-webserver',

    # this the the folder where the source code is hosted
    :source_code_path => '~/code/tempora'

    # if `:os` is `BlackStack::Deployer::LINUX` it will connect via SSH, and run `bash` commands.
    # if `:os` is `BlackStack::Deployer::WIN` it will connect via PowerSheel, and run `win-cmd` commands.
    :os => BlackStack::Deployer::LINUX,

    # activate this flag to:
    # 1. do a change dir to `:source_code_path`; and
    # 2. do a `git fetch --all` and `git reset --all origin/#{branch_name}`.
    :pull_source_code => true,

    # activate this flag to:
    # 1. do a change dir to `:source_code_path`; and
    # 2. do a `bundler update`.
    :update_public_gems => true,

    # activate this flag to:
    # 1. do a change dir to `:source_code_path`; 
    # 2. do a change dir to `./gems`; and
    # 3. do `gem uninstall --all -I #{name}` and a `gem install #{name}`, for all the gems listed on `:private_gems`
    :update_private_gems => true,
    :list_of_private_gems => ['~/code/tempora/gems/stealth_browser_automation', '~/code/tempora/gems/bots', '~/code/tempora/gems/nextbot'],

    # activate this flag to:
    # 1. do a change dir to `:source_code_path`; 
    # 2. rename each one of the existing configuration files with `mv ./#{host_filename} ./#{host_filename}.#{Time.now.utc.strftime("%Y%m%d%H%M%S")}`; 
    # 3. create a new file `./#{config_filename}`; and
    # 4. paste a new content `./#{}`
    :update_configuration_files => true,
    :list_of_configuration_files => [
      { :local_path => "c:\\mycode\\tempora\\config_for_production.yaml", :host_filename => '~/code/tempora/config.yaml' }, 
      { :local_path => "c:\\mycode\\tempora\\db_password_for_production.yaml", :host_filename => '~/code/tempora/db_password.yaml' }, 
    ]

    # activate this flag if you want to restart all the sinatra webservers running.
    # consider they may be more than 1 sinatra processes. 
    :restart_sinatra => true,
    :sinatra_ports => [80, 81, 82],

    # activate this flag to do:
    # 1. run all the one-line commands in the `kill_pampa_one_line_commands` array; and then
    # 2. run all the one-line commands in the `start_pampa_one_line_commands` array. 
    :restart_pampa => true,
    :kill_pampa_one_line_commands => [
      'kill xterm',
      'kill ruby',
      'kill chrome',
      'kill firefox',
      'kill terminal',
    ]
    :start_pampa_one_line_commands => [
      'xterm -e bash -c "cd ~/code/tempora;./shm.rb;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./mlalistener.rb port=45010;bash"',
    ] 
  }],
});
```

Then, add the computers where you want to run deployments.

```ruby
# setup computers
BlackStack::Deployer.set({
  :hosts => [
    { :internet_address => 'ws1.mydomain.com', :remote_access_user => 'computer username', :remote_access_password => 'computer password', :deploying_profile=>'sinatra-webserver' },
    { :internet_address => 'ws2.mydomain.com', :remote_access_user => 'computer username', :remote_access_password => 'computer password', :deploying_profile=>'sinatra-webserver' },
  ]
})
```

## 2. Abstract

**Pampa Deployer** automates what you already know how to do manually, but in a repeatable, scalable fashion. There is no magic here!

Here's what makes Pampa Deployer great:

1. **Strong conventions**: **Pampa Deployer** defines a standard deployment process that all Pampa Deployer-enabled projects follow by default. You don't have to decide how to structure your scripts, where deployed files should be placed on the server, or how to perform common tasks: Pampa Deployer has done this work for you.

2. **Multiple stages**: Define your deployment once, and then easily parameterize it for multiple stages (environments), e.g. qa, staging, and production. No copy-and-paste necessary: you only need to specify what is different for each stage, like IP addresses.

3. **Parallel execution**: Deploying to a fleet of app servers? Pampa Deployer can run each deployment task concurrently across those servers and uses connection pooling for speed.

4. **Server deploying profiles**: Your application may need many different types of servers: a database server, an app server, two web servers, and a job queue work server, for example. Pampa Deployer lets you tag each server with one or more deploying profiles, so you can control what tasks are executed where.

5. Everything in **Pampa Deployer** comes down to running SSH or Powershell commands on remote servers. On the one hand, that makes Pampa Deployer simple. On the other hand, if you aren't comfortable SSH-ing into a Linux box and doing stuff on the command-line, then **Pampa Deployer** is probably not for you.

## 3. Scope

As of today, **Pampa Deployer** supports:

1. database installation & initialization; and
2. releasing database updates.

And we are activelly working to add these features:

3. releasing new source versions; 
4. installation / update of public gems specified in the `Gemfile`;
5. installation / update of private gems hosted on some path inside the source code; 
6. updating configuration files;
7. restarting [Sinatra](http://sinatrarb.com/) web servers;
8. restarting [Pampa](https://github.com/leandrosardi/pampa) workers.

## 4. For Any Language

**Pampa Deployer** written in Ruby, but it can easily be used to deploy any language.

## 5. Dependencies

**Pampa Deployer** uses

1. [Sequel](https://github.com/jeremyevans/sequel) for connecting databases;
2. [Net::SSH](https://github.com/net-ssh/net-ssh) for connecting Linux servers via SSH;
3. [WinRM](https://github.com/WinRb/WinRM) for connecting Windows servers via PowerShell;
and
4. [Bundler](https://bundler.io/) for installing/updating gems.

## 6. Why Not Capistrano?

1. [Capistrano](https://capistranorb.com/) is not fully supporting [Sinatra](http://sinatrarb.com/) or it is not well documented about.

2. [Capistrano](https://capistranorb.com/) is not supporting [PowerShell](https://docs.microsoft.com/en-us/powershell/) to work on Windows computers.

3. **Pampa Deployer** is also more integrated with [Pampa](https://github.com/leandrosardi/pampa), and all our projects at [ExpandedVenture](https://ExpandedVenture.com).


## 2. Database Installation

**Database Installation** is about creating the schema of the database (tables, indexes, keys, triggers, store procedures, etc.)

First, setup your installation job, by specifing one by one the `.sql` scripts to run.

### 2.1. Configuring Database Installation Jobs

```ruby
BlackStack::Deployer.set({
  # Scripts to install the database schema.
  # List them in the order they must be executed.
  # By convention, filenames for installation must match with `/^0./`.
  :database_installation_files=>[
    { 
      :filename=>'./sql/0.a.base-schema.ddl.tsql.sql', 
      :critical=>true, 
      :description=>'All the objects, excel the full-text indexes who are not supported by SQLExpress. This file is critical to keep running the deploying process.', 
    },
    { 
      :filename=>'./sql/0.b.full-text-indexes.ddl.tsql.sql', 
      :critical=>false, 
      :description=>'All the full-text indexes, who are not supported by SQLExpress. Deploying process may keep running even if this file finishes with errors.',
    },    
  ],
});
```

**Specifications:**

1. Set the `:critical` flag in `true` if you want to abort the job if such a file doesn't finish successfully.  

2. The values in the `:filename` entries should match with either `/\.tsql\./` or `/\.sentences\./`.

	- The `/\.tsql\./` files will be processsed each transact-sql codes one by one; each one separated by a `GO` statement

	- The `/\.sentences\./` files will be processed line by line, assuming that each line is one sentence. Example: a list of insert statements.

3. The values in the `:filename` entries should match with `/^0\./` when you are defining the **database installation** job.


Then, write a little script to run the installation.

### 2.2. Running Database Installation Jobs


Find the full example here: [./examples/install.rb](./examples/install.rb).

```ruby
# create a Sequel database connection
DB = Sequel.connect(connection_descriptor)
# run a database installation
BlackStack::Deployer::db_install(nil, db_name, path, size)
```

**Parameters:**

1. **db_name:** The name of the database. The `db_install` process will replace any `%database_name%` wildcard in your `.sql` files.
2. **path:** The location to store the both data and transaction log files. The `db_install` process will replace any `%path%` wildcard in your `.sql` files.
3. **size:** The initial size in MB of both data and transaction log files. The `db_install` process will replace any `%size%` wildcard in your `.sql` files.


## 3. Database Initialization

**Database Initialization** is about:
1. populating the parametric tables; and
2. seed some tables like. Example: insert the first record in the `[user]` with demo credentials.

First, setup your initialization job, by specifing one by one the `.sql` scripts to run.

### 3.1. Configuring Database Initialization Jobs

```ruby
# Seting up deployer.
BlackStack::Deployer.set({
  # Script to insert the parametric values into the new database.
  # List them in the order they must be executed.
  # By convention, the filenames for initialization must match with `/^1./`.
  :database_initialization_files=>[
    { 
      :filename=>'./sql/1.a.parametric-tables.dml.sentences.sql', 
      :critical=>true, 
      :description=>'Add records to parametric tables. This file is critical to keep running the deploying process.', 
    },
    { 
      :filename=>'./sql/1.b.parametric-tables.dml.tsql.sql', 
      :critical=>true, 
      :description=>'Add records to parametric tables. This file is critical to keep running the deploying process.', 
    },
  ],
})
```

**Specifications:**

1. The values in the `:filename` entries should match with `/^1\./` when you are defining the **database initialization** job.

Then, write a little script to run the initialization.

### 3.2. Running Database Initialization Jobs

Find the full example here: [./examples/initialize.rb](./examples/initialize.rb).

```ruby
# create a Sequel database connection
DB = Sequel.connect(connection_descriptor)
# run a database initialization
BlackStack::Deployer::db_initialize(nil, db_name)
```

**Parameters:**

1. **db_name:** The name of the database. The `db_initialize` process will replace any `%database_name%` wildcard in your `.sql` files.

## 4. Database Updates

> IMPORTANT: This feature is still on testing stage.

**Database Update** is about running a series of `.sql` files for executing DDL (data definition language) and/or DML (data manipulation language) updates.

```ruby
# create a Sequel database connection
DB = Sequel.connect(connection_descriptor)
# run a database update
BlackStack::Deployer::db_update(nil, db_name, sql_path, last_filename)
```

**Parameters:**

1. **db_name:** The name of the database. The `db_install` process will replace any `%database_name%` wildcard in your `.sql` files.
2. **sql_path:** The location where find the `.sql` files to run. They will be executed one by one, in alphabetical order.
3. **last_filename:** The name of the last file processed, so your process can resume from where it finished in the last job.

**Specifications:**

1. All files are considered as critical. If any file fails, the exception is raised.

2. The name of all files should match with either `/\.tsql\./` or `/\.sentences\./`.

	- The `/\.tsql\./` files will be processsed each transact-sql codes one by one; each one separated by a `GO` statement

	- The `/\.sentences\./` files will be processed line by line, assuming that each line is one sentence. Example: a list of insert statements.

3. The name of files should be higher than `'1'` (and `/^0\./` too), so you can store all files (installation, initializations, updates) in the same path, and run them all together if you want.

## 5. Releasing New Source Code Versions 

> IMPORTANT: Design & code are still on development stage.

Releasing new source code is about connecting a computer, and running git commands for pulling the latest version of a source code.

```ruby
# setup deploying profiles
BlackStack::Deployer.add_deploying_profile({
	:name => 'sinatra-webserver',
  :source_code_path => '~/code/tempora'
  :os => BlackStack::Deployer::LINUX,
  :pull_source_code => true, 
});
```

The method `BlackStack::Deployer.deploy('master')` will connect via SSH, run the following bash script, and return the output of the execution:

```bash
bash --login
cd ~/code/tempora
git fetch --all
git reset --hard origin/master
```

You can also replace the default `pull` method by a custom method:

```ruby
# setup deploying profiles
BlackStack::Deployer.add_deploying_profile({
	:name => 'sinatra-webserver',
  :source_code_path => '~/code/tempora'
  :os => BlackStack::Deployer::LINUX,
  :pull_source_code => true, 
  :pulling_function => Proc.new do |ssh, *args|
    stdout = ssh.exec!("
      bash --login
      cd ~/code/tempora
      git fetch --all
      git reset --hard origin/master
      chmod +x ~/code/tempora/*.rb
      chmod +x ~/code/tempora/p/*.rb
      chmod +x ~/code/tempora/cli/*.rb
      chmod +x ~/code/tempora/bash/*.sh
    ")
    stdout
  end,
});
```

Here is a good example about how we work dynamically defined methods:
[https://github.com/leandrosardi/pampa_dispatcher/blob/1.1.0/lib/pampa_dispatcher.rb#L143](https://github.com/leandrosardi/pampa_dispatcher/blob/1.1.0/lib/pampa_dispatcher.rb#L143)

## 6. Updating Public Gems

> IMPORTANT: Design & code are still on development stage.

Updating public gems is about running `bundler update` in the remote computer.

```ruby
# setup deploying profiles
BlackStack::Deployer.add_deploying_profile({
	:name => 'sinatra-webserver',
  :source_code_path => '~/code/tempora'
  :os => BlackStack::Deployer::LINUX,
  :update_public_gems => true, 
});
```

The method `BlackStack::Deployer.deploy('master')` will connect via SSH, run the following bash script, and return the output of the execution:

```bash
bash --login
cd ~/code/tempora
bundler update
```

## 7. Updating Private Gems 

> IMPORTANT: Design & code are still on development stage.

Updating private gems is about removing some gems that you store them privately in some directory inside the source code.

```ruby
# setup deploying profiles
BlackStack::Deployer.add_deploying_profile({
	:name => 'sinatra-webserver',
  :source_code_path => '~/code/tempora'
  :os => BlackStack::Deployer::LINUX,
  :update_private_gems => true,
  :list_of_private_gems => ['~/code/tempora/gems/stealth_browser_automation', '~/code/tempora/gems/bots'],
});
```

The method `BlackStack::Deployer.deploy('master')` will connect via SSH, run the following bash script, and return the output of the execution:

```bash
bash --login

cd ~/code/tempora/gems
gem uninstall stealth_browser_automation --all -I
gem install stealth_browser_automation

cd ~/code/tempora/gems
gem uninstall bots --all -I
gem install bots
```

## 8. Updating Configuration Files

> IMPORTANT: Design & code are still on development stage.

Releasing an update of the configuration file is a bit trcky, because configuration files have some secretive infromation (like database passwords) that you don't want to push to the repository.

In consequence, when you have to specify a local path in your own computer from where you are running the deploying job.

```ruby
# setup deploying profiles
BlackStack::Deployer.add_deploying_profile({
	:name => 'sinatra-webserver',
  :source_code_path => '~/code/tempora'
  :os => BlackStack::Deployer::LINUX,
  :update_configuration_files => true,
  :list_of_configuration_files => [
    { :local_path => "c:\\mycode\\tempora\\config_for_production.yaml", :host_path => '~/code/tempora/config.yaml' }, 
    { :local_path => "c:\\mycode\\tempora\\db_password_for_production.yaml", :host_path => '~/code/tempora/db_password.yaml' }, 
  ]
});
```

The method `BlackStack::Deployer.deploy('master')` will connect via SSH, and:

1. It will backup old version of configuration files.
The backup file will have names like `~/code/tempora/config.yyyymmddhhmmmss.yaml`.

and

2. It will create/rewrite configuration files.

## 9. Restarting [Sinatra](http://sinatrarb.com/) Web Servers

> IMPORTANT: Design & code are still on development stage.

The `:restart_sinatra` is about restart the sinatra web server.

```ruby
# setup deploying profiles
BlackStack::Deployer.add_deploying_profile({
	:name => 'sinatra-webserver',
  :source_code_path => '~/code/tempora'
  :os => BlackStack::Deployer::LINUX,
  :restart_sinatra => true,
});
```

Consider that you may have more than one sinatra processes, each one listening one different port:

```ruby
# setup deploying profiles
BlackStack::Deployer.add_deploying_profile({
	:name => 'sinatra-webserver',
  :source_code_path => '~/code/tempora'
  :os => BlackStack::Deployer::LINUX,
  :restart_sinatra => true,
  :sinatra_ports => [80, 81, 82],
});
```

The method `BlackStack::Deployer.deploy('master')` will connect via SSH, restart all the web servers, and return `true` only if the restartings have been done successfully.


## 10. Restarting [Pampa](https://github.com/leandrosardi/pampa) Workers

> IMPORTANT: Design & code are still on development stage.

As of today, our [Pampa](https://github.com/leandrosardi/pampa) is not providing any method to restart the workers from source code.

So, restarting Pampa Workers is a brute force game of killing proccess and launching them again.

```ruby
# setup deploying profiles
BlackStack::Deployer.add_deploying_profile({
	:name => 'sinatra-webserver',
  :source_code_path => '~/code/tempora'
  :os => BlackStack::Deployer::LINUX,
  :restart_pampa => true,
  :kill_pampa_one_line_commands => [
    'kill xterm',
    'kill ruby',
    'kill chrome',
    'kill firefox',
    'kill terminal',
  ]
  :start_pampa_one_line_commands => [
    'xterm -e bash -c "cd ~/code/tempora;./shm.rb;bash"',
    'xterm -e bash -c "cd ~/code/tempora;./mlalistener.rb port=45010;bash"',
  ] 
});
```

The method `BlackStack::Deployer.deploy('master')` will connect via SSH, 

Then, it will run the list of `:start_pampa_one_line_commands` one by one.


