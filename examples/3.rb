# Example script of running a `apt update` command.

require_relative '../lib/blackstack-deployer'

# setup nodes
BlackStack::Deployer::Nodes.set_nodes([{
    :name => 'node1',
    :net_remote_ip => '54.160.137.218',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',
}])

# setup a routine
BlackStack::Deployer::Nodes.set_routines([{
  :name => 'update and upgrade apt',
  :commands => [
    { :command => 'apt update' },
    { :command => 'apt upgrade' },
  ],
}]);

# run the routine
BlackStack::Deployer::Nodes.run('node1', 'update and upgrade apt');