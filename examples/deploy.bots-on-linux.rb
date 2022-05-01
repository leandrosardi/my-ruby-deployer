#!/usr/bin/env ruby

# This script is used to deploy new source code on production servers.
# For more information, see the README.md file.

require 'simple_command_line_parser'
require 'simple_cloud_logging'
require 'pampa_deployer'

require_relative './config.rb'

# setup deploying profiles for different kind of servers.
BlackStack::Deployer.add_deploying_profile({
    :name => 'bots-on-linux',
    :source_code_path => '~/code/tempora'
    :os => BlackStack::Deployer::LINUX,
    :pull_source_code => true,
    :update_public_gems => true,
    :update_private_gems => true,
    :list_of_private_gems => ['~/code/tempora/gems/stealth_browser_automation', '~/code/tempora/gems/bots', '~/code/tempora/gems/nextbot'],
    :update_configuration_files => true,
    :list_of_configuration_files => [
      { :local_path => "c:\\code\\tempora\\config.prod.win.rb", :host_filename => '~/code/tempora/config.rb' }, 
    ],
    :restart_sinatra => false,
    #:sinatra_ports => [80, 81, 82],
    :restart_pampa => true,
    :kill_pampa_one_line_commands => [
      'kill xterm',
      'kill ruby',
      'kill chrome',
      'kill firefox',
      'kill terminal',
      'kill multilogin',
      'kill headless',

    ],
    :start_pampa_one_line_commands => [
      'xterm -e bash -c "cd ~/code/tempora;./shm.rb;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./mlalistener.rb port=45010;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./mlalistener.rb port=45011;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./mlalistener.rb port=45012;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./mlalistener.rb port=45013;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn01;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn02;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn03;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn04;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn05;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn06;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn07;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn08;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn09;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn10;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn11;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn12;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn13;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn14;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn15;bash"',
      'xterm -e bash -c "cd ~/code/tempora;./worker.rb name=unicorn16;bash"',
    ],
});


# setup computers
BlackStack::Deployer.add_host({
    :internet_address => '74.208.37.122', 
    :remote_access_user => 'bots', 
    :remote_access_password => '(ask your team leader for password)', 
    :deploying_profile=>'bots-in-linux' 
})

=begin
#
# Other servers to deploy
# 
# 
74.208.54.249
74.208.93.209
198.251.64.46
74.208.37.202
74.208.116.52
198.71.52.95
74.208.116.50
=end