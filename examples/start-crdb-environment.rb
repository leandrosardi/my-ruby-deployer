# Example script of connecting to an AWS/EC2 instance using a key file; and running a command.

require_relative '../lib/blackstack-deployer'
require_relative './routines/start-crdb-environment'

BlackStack::Deployer::add_nodes([{
    # use this command to connect from terminal: ssh -i "plank.pem" ubuntu@ec2-34-207-235-139.compute-1.amazonaws.com
    :name => 'node0015',
    :net_remote_ip => '34.207.235.139',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',
    :deployment_routine => 'start-crdb-environment',
    #:eth0_ip => 'como cargar un resultado del nodo aqui', # ==> this is a native parameter
    :crdb_database_certs_path => '/home/ubuntu',
    :crdb_database_port => 26257,
    :crdb_dashboard_port => 8080,
}])

# deploy
BlackStack::Deployer::deploy
