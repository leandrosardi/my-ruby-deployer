# Example script of connecting to an AWS/EC2 instance using a key file; and running a command.

require_relative '../lib/blackstack-deployer'
require_relative './routines/change-hostname'
require_relative './routines/upgrade-packages'
require_relative './routines/install-packages'
require_relative './routines/install-ruby'
require_relative './routines/install-project'

BlackStack::Deployer::add_nodes([{
    # use this command to connect from terminal: ssh -i "plank.pem" ubuntu@ec2-34-207-235-139.compute-1.amazonaws.com
    :name => 'node0015',
    :net_remote_ip => '34.207.235.139',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',

    # create-user
    :user => 'blackstack',
    :password => 'blackstack',

    # git project
    :git_project_url => 'https://github.com/leandrosardi/mysaas',
    :git_project_name => 'mysaas',

    :deployment_routine => 'install-ruby-environment',
    #:eth0_ip => 'como cargar un resultado del nodo aqui', # ==> this is a native parameter
    :crdb_database_port => 26257,
    :dashboard_port => 8080,
}])

# setup deploying rutine
BlackStack::Deployer::add_routine({
  :name => 'install-ruby-environment',
  :commands => [
    { :command => :'change-hostname', }, 
    { :command => :'upgrade-packages', }, 
    { :command => :'install-packages', }, 
    { :command => :'install-ruby', }, 
    { :command => :'install-project', },
  ],
});

# deploy
BlackStack::Deployer::run_routine('node0015', 'install-ruby-environment');
