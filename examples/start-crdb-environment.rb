require 'net/ssh'

ssh = Net::SSH.start('34.207.235.139', 'ubuntu', :keys => './plank.pem', :port => 22)

s = "sudo -S su root -c 'pkill cockroach'"
print "#{s}... "
puts ssh.exec!(s)

s = "sudo -S su root -c '
cd ~;
mv /home/ubuntu/certs /home/ubuntu/certs.back.#{rand(1000000)}};
mkdir /home/ubuntu/certs;
mkdir -p /home/ubuntu/my-safe-directory;
cockroach cert create-ca --allow-ca-key-reuse --certs-dir=/home/ubuntu/certs --ca-key=/home/ubuntu/my-safe-directory/ca.key;
cockroach cert create-node localhost 34.207.235.139 172.31.17.244 $(hostname) --certs-dir /home/ubuntu/certs --ca-key /home/ubuntu/my-safe-directory/ca.key;
cockroach cert create-client root --certs-dir=/home/ubuntu/certs --ca-key=/home/ubuntu/my-safe-directory/ca.key;
        '"
print "Installing SSL certifications... "
puts "done (#{ssh.exec!(s)})"

s = "sudo -S su root -c 'cockroach start --advertise-addr=34.207.235.139:26257 --certs-dir=/home/ubuntu/certs --store=node0015 --listen-addr=172.31.17.244:26257 --http-addr=172.31.17.244:8080 --join=34.207.235.139:26257 --background --max-sql-memory=.25 --cache=.25;'"
print "Running start command... "
puts "done (#{ssh.exec!(s)})"

# Use this command to verify the node is running:
# ps ax | grep cockroach | grep -v grep
s = "ps ax | grep cockroach | grep -v grep"
print "#{s}... "
sleep(10)
puts "done (#{ssh.exec!(s)})"

ssh.close

exit(0)

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
