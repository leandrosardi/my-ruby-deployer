require 'rubygems'
require 'net/ssh'

hostname = '74.208.181.174'
username = 'bots' 
password = 'SantoBartolo707' # TODO: Change this to your password

=begin
echo SantoBartolo707 | sudo -S reboot
bash --login
echo SantoBartolo707 | sudo -S systemctl start lightdm
cd /home/bots/code/tempora
cd bash
=end

=begin
bash --login
cd /home/bots/code/tempora
git fetch --all
git reset --hard origin/master
cd gems
gem uninstall bots --all -I
gem install bots
cd ..
echo SantoBartolo707 | sudo -S chmod +x ./*.rb
echo SantoBartolo707 | sudo -S chmod +x ./p/*.rb
echo SantoBartolo707 | sudo -S chmod +x ./bash/*.sh

# verifications
gem list bots
ls ./*.rb
ls ./p/*.rb
ls ./bash/*.sh
=end

print 'Connect... '
ssh = Net::SSH.start(hostname, username, :password => password)
puts 'OK'

=begin
# deployment on worker servers
commands [
    'bash --login',
    'cd /home/bots/code/tempora',
    'git fetch --all',
    'git reset --hard origin/master',
    'cd gems',
    'gem uninstall bots --all -I',
    'gem install bots',
    'cd ..',
    'echo SantoBartolo707 | sudo -S chmod +x ./*.rb',
    'echo SantoBartolo707 | sudo -S chmod +x ./p/*.rb',
    'echo SantoBartolo707 | sudo -S chmod +x ./bash/*.sh',
]
=end

commands = [
#    'bash --login',
#    'echo SantoBartolo707 | sudo -S systemctl start lightdm',
    'xterm -e bash -c "cd ~/code/tempora;./shm.rb;bash"',
]

commands.each do |command|
    print "Executing: #{command}... "
    stdout = ssh.exec!(command)
    puts stdout
end

ssh.close