# BlackStack Deployer

**BlackStack Deployer** automates what you already know how to do manually, but in a repeatable, scalable fashion. There is no magic here!

```ruby
# deploy new version
BlackStack::Deployer.deploy()
```

## For Any Language

**BlackStack Deployer** has been written in Ruby, but it can easily be used to deploy any language.

## 1. Getting Started

**Step 1:** Install BlackStack Deployer.

```bash 
gem intall blackstack-deployer
```

**Step 2:** Add the computers (nodes) where you want to run deployments.

**Important:** The **user** must be a sudoer. 

```ruby
require 'blackstack-deployer'

# setup nodes
BlackStack::Deployer::Node.set_nodes({
  :net_remote_ip => 's1.mydomain.com', 
  :ssh_username => 'username', 
  :ssh_password => 'password', 
}, { 
  :net_remote_ip => 's2.mydomain.com', 
  :ssh_username => 'username', 
  :ssh_password => 'password', 
})
```

**Step 3:** Setup deployment routines.

```ruby
# setup deploying rutines
BlackStack::Deployer::Node.set_routines({
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
});
```

**Step 4:** Run a deployment routine

```ruby
BlackStack::Deployer::Node.run('s1.mydomain.com', 'pull-source-code');
# => true
```

## 2. Adding Validations

You validate the output of each command with an array of regular experessions (`:matches`).

You can also look for a list of well known error messages, listed in the `:nomatches` key.

```ruby
# setup deploying rutines for different kind of servers.
BlackStack::Deployer::Node.add_routines({
  :deploying_rutines => [{
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
          { :nomatch => /Permission Denied/, :error => 'no grants' },
          { :nomatch => /Command not found/, :error => 'kill command is not installed' },
        ]
      },
    ],
  }],
});
```

## 3. Defining Node Profiles

**Step 1:** Define deployment profiles.

```ruby
BlackStack::Deployer::Node.set_profiles({
  :name => 'rpa-node',
  :routines => [
    { :routine => 'pull-source-code' },
    { :routine => 'restart-rpa' },
  ],
}, {
  :name => 'webserver-node',
  :routines => [
    { :routine => 'pull-source-code' },
    { :routine => 'restart-webserver' },
  ],
});
```

**Step 2:** Define nodes again.

```ruby
BlackStack::Deployer::Node.set_nodes({
  :net_remote_ip => 's1.mydomain.com', 
  :ssh_username => 'username', 
  :ssh_password => 'password', 
  :deployment_profile => 'rpa-node',
}, { 
  :net_remote_ip => 's2.mydomain.com', 
  :ssh_username => 'username', 
  :ssh_password => 'password', 
  :deployment_profile => 'rpa-node'
})
```

**Step 3:** Run deployment for all nodes.

```ruby
BlackStack::Deployer::Node.deploy()
```

## 7. Database Installation

**Database Installation** is about creating a new database on your server.

**Important:** This is the only feature that is compatible with PostgreSQL and only with PostgreSQL.
If you are running with  other RDBMS, you should perform this database cration manually.

**Step 1:** Setup Database Connection with All Grants.

This connection is required to create 

1. the new database;
2. the new user to access the new database; and
3. grant the new user to read and write on the new database.

```ruby
# DB ACCESS - KEEP IT SECRET
BlackStack::Deployer::DB::set_superuser ({
  :db_url => 'db.mydomain.com',
  :db_port => '5432',
  :db_name => 'any-master-database',
  :db_user => 'superadmin-username',
  :db_password => 'superadmin-password',
})
```

If you are running on Postgres, `:db_port` use to be `5432`, `:db_name` use to be `'postgres'` and `:db_user` use to be `'postgres'` too.

**Step 2:** Setup the Parameters of the New Database.

```ruby
# DB ACCESS - KEEP IT SECRET
BlackStack::Deployer::DB::set_new_db ({
  :db_name => 'blackstack',
  :db_user => 'blackstack',
  :db_password => 'bsws2022',
})
```

**Step 3:** Create the new database.

```ruby
BlackStack::Deployer::DB::create
# => true
```

## 8. Running Database Updates

This feature works with any RDBMS supported by [Sequel](https://sequel.jeremyevans.net/).

Running database updates consists in:

1. creating the schema of the database,
(tables, indexes, keys, triggers, store procedures, etc.);

2. insert seed rows on the tables; and

3. run updates for both types: DDL and DML.

**Step 1:** Connect the database

```ruby
# DB ACCESS - KEEP IT SECRET
BlackStack::Deployer::DB::connect_new_db ('your Sequel connection string here')
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

## 9. Reprocessing Database Updates

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

## 10. Advanced Features

There are some advanced feature that make **blackstack-deployer** more versatile.

### 10.1. Requesting node reboot 

You can request node reboot as part of a routine. 

```ruby
# setup deploying rutines for different kind of servers.
BlackStack::Deployer::Node.add_routines({
  :deploying_rutines => [{
    :name => 'change-server-name',
    :commands => [
      { :command => "echo 'dbsrv1' > /etc/hostname" },
      { :command => :reboot },
    ],
  }],
});
```

### 10.2. Pass routine parameters

Your can define parameters parameters between `%` chars, as is shown in the code below.

```ruby
# setup deploying rutines for different kind of servers.
BlackStack::Deployer::Node.add_routines({
  :deploying_rutines => [{
    :name => 'change-server-name',
    :commands => [
      { :command => "echo '%hostname%' > /etc/hostname" },
      { :command => :reboot },
    ],
  }],
});
```

The value to assign will be taken from the hash descriptor of the node.

```ruby
BlackStack::Deployer::Node.set_nodes({
  :net_remote_ip => 'db.mydomain.com', 
  :ssh_username => 'username', 
  :ssh_password => 'password', 
  :deployment_profile => 'db-node',
  :hostname => 'dbsrv',
})
```

### 10.3. Calling sub-routines

You can request the execution of a routine as part of a bigger routine. 

```ruby
# setup deploying rutines for different kind of servers.
BlackStack::Deployer::Node.add_routines({
  :deploying_rutines => [{
    :name => 'installation',
    :commands => [
      { :command => :change-server-name },
      { :command => :reboot },
    ],
  }],
});
```

### 10.4. Resuming database deploying from last checkpoint

Usually, the first files in the `sql` folder are regrding the creation of the schema and the seed records.

As long as you work on your software, more `.sql` files will be added, but you don't want to process all the files from the begining each time you have to deploy an update.

Instead, you can choose the last file processed in order to resume the update from that point.

```ruby
BlackStack::Deployer::DB::deploy('20220527.1.transactions.sql');
# => true
```

## 11. Dependencies

**BlackStack Deployer** uses

1. [pg](https://rubygems.org/gems/pg/) for connecting PostgreSQL database; 
2. [Sequel](https://github.com/jeremyevans/sequel) for simplifying some database tasks;
3. [Net::SSH](https://github.com/net-ssh/net-ssh) for connecting Linux servers via SSH;


