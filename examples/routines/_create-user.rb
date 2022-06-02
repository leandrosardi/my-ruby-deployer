# setup deploying rutines
BlackStack::Deployer::add_routine({
  :name => 'create-user',
  :commands => [
    { 
        # create a new %user% user.
        :command => 'useradd -m -d /home/%user% %user%', 
        :matches => [/^$/i, /already exists/i], # the success of the command doesn't return anyting.
        :nomatches => [
            { :nomatch => /error/, :error_description => 'An Error Occurred' }, 
            { :nomatch => /denied/i, :error_description => 'An Error Occurred' },
            { :nomatch => /cannot/i, :error_description => 'An Error Occurred' },
        ] 
    }, { 
        # change the password of the %user% user.
        # reference: https://askubuntu.com/questions/80444/how-to-set-user-passwords-using-passwd-without-a-prompt
        :command => 'usermod --password $(echo %password% | openssl passwd -1 -stdin) %user%', 
        :matches => [/^$/i], # the success of the command doesn't return anyting.
        :nomatches => [
            { :nomatch => /error/, :error_description => 'An Error Occurred' }, 
            { :nomatch => /denied/i, :error_description => 'An Error Occurred' },
            { :nomatch => /cannot/i, :error_description => 'An Error Occurred' },
        ] 
    }, { 
        # add %user% to the sudoers group.
        :command => 'adduser %user% sudo', 
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