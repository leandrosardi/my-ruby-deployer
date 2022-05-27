# Example script of connecting to an AWS/EC2 instance and running a command.

require_relative '../lib/blackstack-deployer'
n = BlackStack::Infrastructure::RemoteNode.new(
    :net_remote_ip => '54.160.137.218',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',
)
# => BlackStack::Infrastructure::RemoteNode

n.connect
# => n.ssh

puts n.ssh.exec!('hostname')
# => 'ip-172-31-21-6'

n.disconnect
# => nil

