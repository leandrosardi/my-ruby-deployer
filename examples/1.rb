# Example script of connecting to a VPS.

require_relative '../lib/blackstack-deployer'
n = BlackStack::Infrastructure::RemoteNode.new(
    :net_remote_ip => '81.28.96.103', #'54.160.137.218',
    :ssh_username => 'root',
    :ssh_port => 22,
    :ssh_password => 'fr*****M',
)
# => BlackStack::Infrastructure::RemoteNode

n.connect
# => n.ssh

puts n.ssh.exec!('hostname')
# => 'ns1063'

n.disconnect
# => nil

