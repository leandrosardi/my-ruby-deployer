# Example script of connecting to an AWS/EC2 instance using a key file; and running a command.

require_relative '../lib/blackstack-deployer'

# add node to the cluster
BlackStack::Deployer::add_node({
    :name => 'node0004',
    :net_remote_ip => '34.203.199.68',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',
    :deployment_routine => 'web-servers',
    #:eth0_ip => 'como cargar un resultado del nodo aqui', # ==> this is a native variable
    :db_port => 26257,
    :dashboard_port => 8080,
})

BlackStack::Deployer::add_node({
    :name => 'node0005',
    :net_remote_ip => '18.204.216.148',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',
    :deployment_routine => 'web-servers',
    #:eth0_ip => 'como cargar un resultado del nodo aqui', # ==> this is a native variable
    :db_port => 26257,
    :dashboard_port => 8080,
})

BlackStack::Deployer::add_node({
    :name => 'node0006',
    :net_remote_ip => '3.85.160.41',  
    :ssh_username => 'ubuntu',
    :ssh_port => 22,
    :ssh_private_key_file => './plank.pem',
    :deployment_routine => 'web-servers',
    #:eth0_ip => 'como cargar un resultado del nodo aqui', # ==> this is a native variable
    :db_port => 26257,
    :dashboard_port => 8080,
})


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

# setup deploying rutines
BlackStack::Deployer::add_routine({
  :name => 'upgrade-packages',
  :commands => [
    { 
        :command => 'apt update', 
        :matches => [/packages can be upgraded/i, /All packages are up to date/i], 
        :nomatches => [{ :nomatch => /error/, :error_description => 'An Error Occurred' }] 
    }, { 
        :command => 'apt -y upgrade', 
        :matches => [/done/, /(\d)+ upgraded, (\d)+ newly installed, (\d)+ to remove and (\d)+ not upgraded/i], 
        :nomatches => [{ :nomatch => /error/, :error_description => 'An Error Occurred' }] 
    },
  ],
});

# setup deploying rutines
BlackStack::Deployer::add_routine({
  :name => 'create-blackstack-user',
  :commands => [
    { 
        # create a new blackstack user.
        :command => 'useradd -m -d /home/blackstack blackstack', 
        :matches => [/^$/i, /already exists/i], # the success of the command doesn't return anyting.
        :nomatches => [
            { :nomatch => /error/, :error_description => 'An Error Occurred' }, 
            { :nomatch => /denied/i, :error_description => 'An Error Occurred' },
            { :nomatch => /cannot/i, :error_description => 'An Error Occurred' },
        ] 
    }, { 
        # change the password of the blackstack user.
        # reference: https://askubuntu.com/questions/80444/how-to-set-user-passwords-using-passwd-without-a-prompt
        :command => 'usermod --password $(echo SantaClara123 | openssl passwd -1 -stdin) blackstack', 
        :matches => [/^$/i], # the success of the command doesn't return anyting.
        :nomatches => [
            { :nomatch => /error/, :error_description => 'An Error Occurred' }, 
            { :nomatch => /denied/i, :error_description => 'An Error Occurred' },
            { :nomatch => /cannot/i, :error_description => 'An Error Occurred' },
        ] 
    }, { 
        # add blackstack to the sudoers group.
        :command => 'adduser blackstack sudo', 
        :matches => [/Done./i, /is already a member of/], 
        :nomatches => [
            { :nomatch => /Only root may add a user or group to the system/, :error_description => 'An Error Occurred' }, 
            { :nomatch => /error/, :error_description => 'An Error Occurred' }, 
            { :nomatch => /denied/i, :error_description => 'An Error Occurred' },
            { :nomatch => /cannot/i, :error_description => 'An Error Occurred' },
        ] 
    },
  ],
});

# setup deploying rutines
BlackStack::Deployer::add_routine({
  :name => 'install-packages',
  :commands => [
    { 
        :command => 'apt install -y net-tools', 
        :matches => [/(\d)+ upgraded, (\d)+ newly installed, (\d)+ to remove and (\d)+ not upgraded/i], 
        :nomatches => [
            { :nomatch => /Unable to locate package/, :error_description => 'Unable to locate package' }, 
            { :nomatch => /^E: /i, :error_description => 'An Error Occurred' },
        ] 
    }, { 
        :command => 'apt install -y gnupg2', 
        :matches => [/(\d)+ upgraded, (\d)+ newly installed, (\d)+ to remove and (\d)+ not upgraded/i], 
        :nomatches => [
            { :nomatch => /Unable to locate package/, :error_description => 'Unable to locate package' }, 
            { :nomatch => /^E: /i, :error_description => 'An Error Occurred' },
        ] 
    }, { 
        :command => 'apt install -y git', 
        :matches => [/(\d)+ upgraded, (\d)+ newly installed, (\d)+ to remove and (\d)+ not upgraded/i], 
        :nomatches => [
            { :nomatch => /Unable to locate package/, :error_description => 'Unable to locate package' }, 
            { :nomatch => /^E: /i, :error_description => 'An Error Occurred' },
        ]
    }, { 
        :command => 'apt install -y libpq-dev', 
        :matches => [/(\d)+ upgraded, (\d)+ newly installed, (\d)+ to remove and (\d)+ not upgraded/i], 
        :nomatches => [
            { :nomatch => /Unable to locate package/, :error_description => 'Unable to locate package' }, 
            { :nomatch => /^E: /i, :error_description => 'An Error Occurred' },
        ]    
    },
  ],
});

# setup deploying rutines
BlackStack::Deployer::add_routine({
  :name => 'install-ruby',
  :commands => [
    { 
        :command => 'cd /tmp; curl -sSL https://get.rvm.io -o rvm.sh', 
        :nomatches => [ # no output means success.
            { :nomatch => /.+/i, :error_description => 'An Error Occurred' },
        ],
        :sudo => false,
    }, { 
        :command => "gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB;cat /tmp/rvm.sh | bash -s stable --rails", 
        :matches => [/(\d)+ gems installed/i, /1 gem installed/i],
        :nomatches => [ 
            { :nomatch => /error/i, :error_description => 'An Error Occurred' },
        ],
        :sudo => false,
    }, { 
        # reference: https://askubuntu.com/questions/504546/error-message-source-not-found-when-running-a-script
        :command => "source /home/%ssh_username%/.rvm/scripts/rvm; rvm install 3.1.2; rvm --default use 3.1.2;", 
        :matches => [ /Already installed/i,  /installed/i, /generating default wrappers/i ],
        :sudo => false,    

    # TODO: Add validation the ruby 3.1.2 has been installed for the user %ssh_username%.

=begin
    # bundler already installed with Ruby 3.1.2
    }, { 
        # reference: https://askubuntu.com/questions/504546/error-message-source-not-found-when-running-a-script
        :command => "echo 'SantaClara123' | sudo -S su %ssh_username% -c '#!/bin/bash; gem install bundler -v '2.3.7';'", 
        :nomatches => [ # no output means success.
            { :nomatch => /.+/i, :error_description => 'An Error Occurred' },
        ],
        :sudo => false,    
=end
    },
  ],
});

# setup deploying rutines
BlackStack::Deployer::add_routine({
  :name => 'install-free-membership-sites',
  :commands => [
    { 
        :command => 'mkdir ~/code',
        :matches => [ /^$/i, /File exists/i ],
        :sudo => false,
    }, { 
        :command => 'cd ~/code; git clone https://github.com/leandrosardi/free-membership-sites',
        :matches => [ 
            /already exists and is not an empty directory/i,
            /Cloning into/i,
            /Resolving deltas\: 100\% \((\d)+\/(\d)+\), done\./i,
            /fatal\: destination path \'free-membership-sites\' already exists and is not an empty directory\./i,
        ],
        :nomatches => [ # no output means success.
            { :nomatch => /error/i, :error_description => 'An Error Occurred' },
        ],
        :sudo => false,
    }, { 
        :command => 'source /home/%ssh_username%/.rvm/scripts/rvm; cd ~/code/free-membership-sites; rvm install 3.1.2; rvm --default use 3.1.2; bundler update',
        :matches => [ 
            /Bundle updated\!/i,
        ],
        :nomatches => [ 
            { :nomatch => /not found/i, :error_description => 'An Error Occurred' },
        ],
        :sudo => false,
    },
  ],
});

# setup deploying rutines
BlackStack::Deployer::add_routine({
  :name => 'install-cockrouch-cluster',
  :commands => [
    { 
        :command => 'curl https://binaries.cockroachdb.com/cockroach-v21.2.10.linux-amd64.tgz | tar -xz && sudo cp -i cockroach-v21.2.10.linux-amd64/cockroach /usr/local/bin/',
    }, { 
        :command => 'mkdir -p /usr/local/lib/cockroach',
    }, { 
        # reference: https://stackoverflow.com/questions/8488253/how-to-force-cp-to-overwrite-without-confirmation
        :command => 'yes | cp -i cockroach-v21.2.10.linux-amd64/lib/libgeos.so /usr/local/lib/cockroach/',
    }, { 
        # reference: https://stackoverflow.com/questions/8488253/how-to-force-cp-to-overwrite-without-confirmation
        :command => 'yes | cp -i cockroach-v21.2.10.linux-amd64/lib/libgeos_c.so /usr/local/lib/cockroach/',
    }, 
    # TODO: add valdiation `which cockroach`
    { 
        :command => 'cd ~; mkdir certs',
    },
    { 
        :command => 'cd ~; mkdir my-safe-directory',
    },
    { 
        :command => 'cd ~; cockroach cert create-ca --certs-dir=certs --ca-key=my-safe-directory/ca.key',
    },
    { 
        :command => 'cd ~; cockroach cert create-node localhost %eth0_ip% $(hostname) --certs-dir certs --ca-key my-safe-directory/ca.key',
    },
    { 
        :command => 'cd ~; cockroach cert create-client root --certs-dir=certs --ca-key=my-safe-directory/ca.key',
    },
    { 
        :command => 'cd ~; cockroach start --certs-dir=certs --store=node0004 --listen-addr=%eth0_ip%:%db_port% --http-addr=%eth0_ip%:%dashboard_port% --join=%eth0_ip%:%db_port% --background --max-sql-memory=.25 --cache=.25',
    },
    { 
        :command => 'cd ~; cockroach init --host=%eth0_ip%:%db_port% --certs-dir=certs',
    },
    # TODO: connect the cockroach cluster, create database and user and grants.
    #cd ~;cockroach sql --host 34.203.199.68 --certs-dir certs -e "CREATE USER IF NOT EXISTS %ssh_username% WITH PASSWORD 'bsws2022';"
  ],
});


# setup deploying rutines
BlackStack::Deployer::add_routine({
  :name => 'install-full-node-on-aws-on-ubuntu-20-04',
  :commands => [
    { :command => :'change-hostname', }, 
    { :command => :'upgrade-packages', }, 
    { :command => :'install-packages', }, 
    { :command => :'install-ruby', }, 
    { :command => :'install-free-membership-sites', },
  ],
});

BlackStack::Deployer::run_routine('node0006', 'install-full-node-on-aws-on-ubuntu-20-04');

=begin
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
=end