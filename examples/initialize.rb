#!/usr/bin/env ruby

# This script is used to deploy the database changes to the production server.
# For more information, see the README.md file.

require 'simple_command_line_parser'
require 'simple_cloud_logging'
require 'sequel'
require 'pampa_deployer'

require_relative './config.rb'

# command line parameters 
PARSER = BlackStack::SimpleCommandLineParser.new(
  :description => 'This command will launch the browser of a social account, login or signup, confirm the email address and edit the profile.', 
  :configuration => [{
    :name=>'db_url', 
    :mandatory=>true, 
    :description=>'URL of the database. This is mandatory.', 
    :type=>BlackStack::SimpleCommandLineParser::STRING,
  }, {
    :name=>'db_port', 
    :mandatory=>false, 
    :description=>'Listening port of the database. Default value is 1433.', 
    :type=>BlackStack::SimpleCommandLineParser::INT,
    :default=>1400,
  }, {
    :name=>'db_user', 
    :mandatory=>true, 
    :description=>'Database user with grants to access the [master] database and create new databases also. This is mandatory.', 
    :type=>BlackStack::SimpleCommandLineParser::STRING,
  }, {
    :name=>'db_password', 
    :mandatory=>true, 
    :description=>'Password of the db_user. This is mandatory.', 
    :type=>BlackStack::SimpleCommandLineParser::STRING,
  }, {
    :name=>'db_name', 
    :mandatory=>true, 
    :description=>'Name of the new database that will be created. This is mandatory.', 
    :type=>BlackStack::SimpleCommandLineParser::STRING,
  }, {
    :name=>'db_timeout', 
    :mandatory=>false, 
    :description=>'Timeout in seconds for both query and connection. Default value is 60.', 
    :type=>BlackStack::SimpleCommandLineParser::INT,
    :default=>60,
  }, {
    :name=>'app_email', 
    :mandatory=>true, 
    :description=>'Login email address for the super-user of tempora. This is mandatory.', 
    :type=>BlackStack::SimpleCommandLineParser::STRING,
  }, {
    :name=>'app_password', 
    :mandatory=>true, 
    :description=>'Login password for the super-user of tempora. This is mandatory.', 
    :type=>BlackStack::SimpleCommandLineParser::STRING,
  }, {
    :name=>'app_local_address', 
    :mandatory=>false, 
    :description=>'IP address or hostname of the server, inside the LAN. Default value: 127.0.0.1, useful for development environment only.', 
    :type=>BlackStack::SimpleCommandLineParser::STRING,
    :default=>'127.0.0.1',
  }, {
    :name=>'app_internet_address', 
    :mandatory=>false, 
    :description=>'Dimain name or IP address of the server, publshed in the Internet. Default value: 127.0.0.1, useful for development environment only.', 
    :type=>BlackStack::SimpleCommandLineParser::STRING,
    :default=>'127.0.0.1',
  }, {
    :name=>'app_internet_port', 
    :mandatory=>false, 
    :description=>'Port to access the server from the Internet. Default value: 443.', 
    :type=>BlackStack::SimpleCommandLineParser::STRING,
    :default=>'443',  
  }, {
    :name=>'sinatra_ports', 
    :mandatory=>false, 
    :description=>'Comma separated list of ports for the sinatra listeners. Default value: 81,83. If you are installing this on production, on a dedicated server, then force this to: 81,82,87,88,89.', 
    :type=>BlackStack::SimpleCommandLineParser::STRING,
    :default=>'81,83',
  }, {
    :name=>'path', 
    :mandatory=>false, 
    :description=>'Location where the database files will be hosted. By default, it is c:.', 
    :type=>BlackStack::SimpleCommandLineParser::STRING,
    :default=>'c:\code\tempora',
  }, {
    :name=>'size', 
    :mandatory=>false, 
    :description=>'Initial size in MB for both database and transaction log files. By default, it is 512.', 
    :type=>BlackStack::SimpleCommandLineParser::STRING,
    :default=>512,    
  }]
)

#db_url=127.0.0.1 db_port=1433 db_user=coder db_password=coder db_name=central email=<your email here> password=<your password here>

logger = BlackStack::BaseLogger.new(nil)

logger.log 'Welcome to install-central.rb!'

logger.logs 'Setting up database connection...'
connection_descriptor = {
    :adapter => 'tinytds',
    :dataserver => PARSER.value('db_url'), # IP or hostname
    :port => PARSER.value('db_port'), # Required when using other that 1433 (default)
    :database => 'master', # connect the master to create the central database
    :user => PARSER.value('db_user'),
    :password => PARSER.value('db_password'),
    :timeout => PARSER.value('db_timeout')
}  
DB = Sequel.connect(connection_descriptor)
logger.done

logger.logs 'Checking connection...'
logger.logf("done (#{DB["select db_name() as name"].first[:name]})")

logger.logs 'Database initialization...'
BlackStack::Deployer::db_initialize(logger, PARSER.value('db_name'))
logger.done