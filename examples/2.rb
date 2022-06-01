# encoding: utf-8

# Example script of connecting to an AWS/EC2 instance using a key file; and running a command.

require_relative '../lib/blackstack-deployer'

BlackStack::Deployer::DB::connect("postgres://blackstack:bsws2022@54.84.218.106:26257/blackstack")

BlackStack::Deployer::DB::set_folder ('C:\code2\blackstack-deployer\sql');

BlackStack::Deployer::DB::set_checkpoint('0.b.schema.ddl.sql')

BlackStack::Deployer::DB::deploy();