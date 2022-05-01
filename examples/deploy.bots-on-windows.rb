#!/usr/bin/env ruby

# This script is used to deploy new source code on production servers.
# For more information, see the README.md file.

require 'simple_command_line_parser'
require 'simple_cloud_logging'
require 'pampa_deployer'

require_relative './config.rb'

# setup deploying profiles for different kind of servers.
BlackStack::Deployer.add_deploying_profile({
    :name => 'bots-on-windows',
    :source_code_path => 'y:'
    :os => BlackStack::Deployer::WIN,
    :pull_source_code => true,
    :update_public_gems => true,
    :update_private_gems => true,
    :list_of_private_gems => ['y:/gems/stealth_browser_automation', 'y:/gems/bots', 'y:/gems/nextbot'],
    :update_configuration_files => true,
    :list_of_configuration_files => [
      { :local_path => "c:\\code\\tempora\\config.prod.win.rb", :host_filename => 'y:/config.rb' }, 
    ],
    :restart_sinatra => false,
    #:sinatra_ports => [80, 81, 82],
    :restart_pampa => true,
    :kill_pampa_one_line_commands => [
      'taskkill /F /IM ruby.exe',
      'taskkill /F /IM nginx.exe',
      'taskkill /F /IM ipconfig.exe',
      'taskkill /F /IM chrome.exe',
      'taskkill /F /IM chromedriver.exe',
      'taskkill /F /IM multilogin.exe',
    ],
    :start_pampa_one_line_commands => [
      'start cmd /k "c: && y:\shm.rb"',
      'start cmd /k "c: && y:\mlalistener.rb port=45010"',
      'start cmd /k "c: && y:\mlalistener.rb port=45011"',
      'start cmd /k "y: && worker.rb name=unicorn01"',
      'start cmd /k "y: && worker.rb name=unicorn02"',
      'start cmd /k "y: && worker.rb name=unicorn03"',
      'start cmd /k "y: && worker.rb name=unicorn04"',
      'start cmd /k "y: && worker.rb name=unicorn05"',
      'start cmd /k "y: && worker.rb name=unicorn06"',
      'start cmd /k "y: && worker.rb name=unicorn07"',
      'start cmd /k "y: && worker.rb name=unicorn08"',
      'start cmd /k "y: && worker.rb name=unicorn09"',
      'start cmd /k "y: && worker.rb name=unicorn10"',
      'start cmd /k "y: && worker.rb name=unicorn11"',
      'start cmd /k "y: && worker.rb name=unicorn12"',
    ],
});


# setup computers
BlackStack::Deployer.add_host({
    :internet_address => '108.175.7.159', 
    :remote_access_user => 'Administrator', 
    :remote_access_password => '(ask your team leader for password)', 
    :deploying_profile=>'bots-in-windows' 
})

=begin
#
# Other servers to deploy
# 
# 
108.175.7.159
74.208.181.65
74.208.117.90
74.208.48.83
74.208.187.124
=end