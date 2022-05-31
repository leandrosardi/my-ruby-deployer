# Example script of connecting to an AWS/EC2 instance using a key file; and running a command.

require_relative '../lib/blackstack-deployer'

# add node to the cluster
BlackStack::Deployer::add_node({
    :name => 'node1',
    :net_remote_ip => '54.160.137.218',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',
    :deployment_routine => 'web-servers',
})

n = BlackStack::Deployer.nodes.first
n.connect
puts n.ssh.exec!('ls')
n.disconnect
exit(0)

# setup deploying rutines
BlackStack::Deployer::set_routines([{
  :name => 'pull-source-code',
  :commands => [
    { :command => 'cd ~/code/free-membership-sites', :nomatches => [{ :nomatch => /No such file or directory/, :error_description => 'No such file or directory' }] },
    { :command => 'git fetch --all', :nomatches => [{ :nomatch => /Fatal\:/, :error_description => 'Fatal Error Occurred' }] },
    { :command => 'git reset --hard origin/main', :nomatches => [{ :nomatch => /Fatal\:/, :error_description => 'Fatal Error Occurred' }] },
  ],
}]);

BlackStack::Deployer::run_routine('node1', 'pull-source-code');