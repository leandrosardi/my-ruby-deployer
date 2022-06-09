Gem::Specification.new do |s|
  s.name        = 'blackstack-deployer'
  s.version     = '1.2.11'
  s.date        = '2022-06-09'
  s.summary     = "BlackStack Deployer is a deployment automation tool built on Ruby and SSH."
  s.description = "BlackStack Deployer automates what you already know how to do manually, but in a repeatable, scalable fashion. There is no magic here!
BlackStack Deployer dutifully connects to your server(s) via SSH and executes the steps necessary to deploy your project. 
You can define those steps yourself, or by using pre-built task libraries provided by the BlackStack Deployer community.
  "
  s.authors     = ["Leandro Daniel Sardi"]
  s.email       = 'leandro.sardi@expandedventure.com'
  s.files       = [
    "lib/blackstack-deployer.rb",
  ]
  s.homepage    = 'https://rubygems.org/gems/blackstack-deployer'
  s.license     = 'MIT'
  s.add_runtime_dependency 'blackstack-nodes', '~> 1.2.7', '>= 1.2.7'
  s.add_runtime_dependency 'pg', '~> 1.3.5', '>= 1.3.5'
  s.add_runtime_dependency 'sequel', '~> 5.56.0', '>= 5.56.0'
#  s.add_runtime_dependency 'websocket', '~> 1.2.8', '>= 1.2.8'
#  s.add_runtime_dependency 'json', '~> 2.3.0', '>= 2.3.0'
#  s.add_runtime_dependency 'pg', '~> 1.3.5', '>= 1.3.5'
#  s.add_runtime_dependency 'sequel', '~> 4.28.0', '>= 4.28.0'
end