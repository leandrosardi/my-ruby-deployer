require_relative '../lib/blackstack-deployer'

n = BlackStack::Infrastructure::RemoteNode.new(
    :net_remote_ip => 'ec2-54-160-137-218.compute-1.amazonaws.com', #'54.160.137.218',
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => 'C:\Users\Leandro\Desktop\plank.pem',
)

ssh = n.connect

output = ssh.exec!('ls -l')

puts output

