# Example script of connecting to an AWS/EC2 instance using a key file; and running a command.

require 'my-ruby-deployer'

# routines
BlackStack::Deployer::add_routine({
  :name => 'change-hostname',
  :commands => [
    { 
        :command => '
            echo "%name%" > /etc/hostname
        ', 
    }, { 
        :command => :reboot
    },
  ],
});

# declare nodes
BlackStack::Deployer::add_nodes([{
    # use this command to connect from terminal: ssh -i "plank.pem" ubuntu@ec2-34-234-83-88.compute-1.amazonaws.com
    :name => 'node01',
    :net_remote_ip => '127.0.0.1',  
    :ssh_username => 'leandro',
    :ssh_password => '2404',
    :ssh_port => 22,
    :deployment_routine => 'change-hostname',
}])

# deploy
BlackStack::Deployer::deploy
