# change hostname
BlackStack::Deployer::add_routine({
  :name => 'change-hostname',
  :commands => [
    { 
        :command => 'echo "%name%" > /etc/hostname', 
    }, { 
        :command => :reboot
    },
  ],
});