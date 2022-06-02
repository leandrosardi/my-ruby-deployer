# Example script of connecting to an AWS/EC2 instance using a key file; and running a command.

require_relative '../lib/blackstack-deployer'
require_relative './routines/change-hostname'

# declare nodes
BlackStack::Deployer::add_nodes([{
    # use this command to connect from terminal: ssh -i "plank.pem" ubuntu@ec2-34-234-83-88.compute-1.amazonaws.com
    :name => 'node0011b',
    :net_remote_ip => '34.234.83.88',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',
    :deployment_routine => 'change-hostname',
}])

# deploy
BlackStack::Deployer::deploy
