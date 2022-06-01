# Example script of connecting to an AWS/EC2 instance using a key file; and running a command.

require_relative '../lib/blackstack-deployer'

BlackStack::Deployer::add_nodes([{
    :name => 'node0011',
    :net_remote_ip => '34.234.83.88',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',
    :deployment_routine => 'web-servers',
    #:eth0_ip => 'como cargar un resultado del nodo aqui', # ==> this is a native parameter
    :db_port => 26257,
    :dashboard_port => 8080,
}, {
    :name => 'node0012',
    :net_remote_ip => '54.84.218.106',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',
    :deployment_routine => 'web-servers',
    #:eth0_ip => 'como cargar un resultado del nodo aqui', # ==> this is a native parameter
    :db_port => 26257,
    :dashboard_port => 8080,
}, {
    :name => 'node0013',
    :net_remote_ip => '44.203.118.42',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',
    :deployment_routine => 'web-servers',
    #:eth0_ip => 'como cargar un resultado del nodo aqui', # ==> this is a native parameter
    :db_port => 26257,
    :dashboard_port => 8080,
}])


