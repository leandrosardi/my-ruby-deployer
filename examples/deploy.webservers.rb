#!/usr/bin/env ruby

# This script is used to deploy new source code on production servers.
# For more information, see the README.md file.

require 'simple_command_line_parser'
require 'simple_cloud_logging'
require 'pampa_deployer'

require_relative './config.rb'

# setup deploying profiles for different kind of servers.
BlackStack::Deployer.add_deploying_profile({
    :name => 'webservers',
    :source_code_path => 'y:/code/tempora'
    :os => BlackStack::Deployer::WIN,
    :pull_source_code => true,
    :update_public_gems => true,
    :update_private_gems => true,
    :list_of_private_gems => ['y:/gems/stealth_browser_automation', 'y:/gems/bots', 'y:/gems/nextbot'],
    :update_configuration_files => true,
    :list_of_configuration_files => [
      { :local_path => "c:\\code\\tempora\\config.prod.win.rb", :host_filename => 'y:/code/tempora/config.rb' }, 
    ],
    :restart_sinatra => true,
    :sinatra_ports => [81, 82, 87, 88, 89, 90, 91, 92, 93, 94],
    :restart_pampa => false,
    #:kill_pampa_one_line_commands => [],
    #:start_pampa_one_line_commands => [],
});


# setup computers
BlackStack::Deployer.add_host({
    :internet_address => '74.208.28.38', 
    :remote_access_user => 'Administrator', 
    :remote_access_password => '(ask your team leader for password)', 
    :deploying_profile=>'webservers',
})

=begin
#
# Other servers to deploy
# 
# 
74.208.28.38
198.71.49.144
74.208.92.68
74.208.92.74
=end