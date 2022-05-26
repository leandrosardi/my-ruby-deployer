Gem::Specification.new do |s|
  s.name        = 'blackstack-deployer'
  s.version     = '1.2.1'
  s.date        = '2022-04-22'
  s.summary     = "THIS GEM IS STILL IN DEVELOPMENT STAGE. Distribute work along a pool of Pampa workers."
  s.description = "THIS GEM IS STILL IN DEVELOPMENT STAGE. Find documentation here: https://github.com/leandrosardi/pampa_dispatcher."
  s.authors     = ["Leandro Daniel Sardi"]
  s.email       = 'leandro.sardi@expandedventure.com'
  s.files       = [
    "lib/pampa_deployer.rb",
  ]
  s.homepage    = 'https://rubygems.org/gems/blackstack-deployer'
  s.license     = 'MIT'
  s.add_runtime_dependency 'net-ssh', '~> 4.1.0', '>= 4.1.0'
  s.add_runtime_dependency 'websocket', '~> 1.2.8', '>= 1.2.8'
  s.add_runtime_dependency 'json', '~> 1.8.1', '>= 1.8.1'
  s.add_runtime_dependency 'pg', '~> 1.3.5', '>= 1.3.5'
  s.add_runtime_dependency 'sequel', '~> 4.28.0', '>= 4.28.0'
end