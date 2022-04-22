# Pampa Deployer

**Pampa Deployer** releases new code versions along a pool of **[Pampa Workers](https://github.com/leandrosardi/pampa)**.

Note that any **deployer** works with a direct connection to the database. All the examples below will work this way.  

On the other hand, **workers** may be distributed worldwide, and don't require direct connection to the database.

# 1. Getting Started

## 1.1. Installation

```cmd
gem install pampa_deployer
```

The **Pampa Deployer** gem requires **[Sequel](https://sequel.jeremyevans.net/)** 4.28.0.

## 1.2. Configuring Database Installation Jobs

**Database Installation** is about creating the schema of the database (tables, indexes, keys, triggers, store procedures, etc.)

First, setup your installation job, by specifing one by one the `.sql` scripts to run.

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

## 1.3. Running Database Installation Jobs

Then, write a little script to run the installation.

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

## 1.3. Configuring Database Initialization Jobs

**Database Initialization** is about:
1. populating the parametric tables; and
2. seed some tables like. Example: insert the first record in the `[user]` with demo credentials.

First, setup your initialization job, by specifing one by one the `.sql` scripts to run.

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

## 1.4. Running Database Initialization Jobs

Then, write a little script to run the initialization.

Find the full example here: [./examples/initialize.rb](./examples/initialize.rb).

```ruby
# create a Sequel database connection
DB = Sequel.connect(connection_descriptor)
# run a database initialization
BlackStack::Deployer::db_initialize(nil, db_name)
```

**Parameters:**

1. **db_name:** The name of the database. The `db_initialize` process will replace any `%database_name%` wildcard in your `.sql` files.

# 2. Running Database Updates

**Database Update** is about running a series of `.sql` files with updates to the database.

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