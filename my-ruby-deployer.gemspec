Gem::Specification.new do |s|
  s.name        = 'my-ruby-deployer'
  s.version     = '1.3.4'
  s.date        = '2024-03-29'
  s.summary     = "Deployer is a deployment automation tool built on Ruby and SSH."
  s.description = "Deployer automates what you already know how to do manually, but in a repeatable, scalable fashion. There is no magic here!
Deployer dutifully connects to your server(s) via SSH and executes the steps necessary to deploy your project. 
You can define those steps yourself, or by using pre-built task libraries provided by the Deployer community.
  "
  s.authors     = ["Leandro Daniel Sardi"]
  s.email       = 'leandro.sardi@expandedventure.com'
  s.files       = [
    "lib/my-ruby-deployer.rb",
  ]
  s.homepage    = 'https://rubygems.org/gems/my-ruby-deployer'
  s.license     = 'MIT'
  s.add_runtime_dependency 'blackstack-nodes', '~> 1.2.12', '>= 1.2.12'
  s.add_runtime_dependency 'pg', '~> 1.3.5', '>= 1.3.5'
  s.add_runtime_dependency 'sequel', '~> 5.56.0', '>= 5.56.0'
  #s.add_runtime_dependency 'websocket', '~> 1.2.8', '>= 1.2.8'
  #s.add_runtime_dependency 'json', '~> 2.3.0', '>= 2.3.0'
  s.add_runtime_dependency 'colorize', '~> 0.8.1', '>= 0.8.1'
  s.add_runtime_dependency 'simple_cloud_logging', '~> 1.2.2', '>= 1.2.2'
end