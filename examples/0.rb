# Example script of connecting to an AWS/EC2 instance using a key file; and running a command.

require_relative '../lib/blackstack-deployer'

# add node to the cluster
BlackStack::Deployer::add_node({
    :name => 'test-node',
    :net_remote_ip => '54.160.137.218',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',
    :deployment_routine => 'web-servers',
})

# setup deploying rutines
BlackStack::Deployer::set_routines([{
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
