lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'calamum/version'
Gem::Specification.new do |gem|
  gem.name          = 'calamum'
  gem.version       = Calamum::VERSION
  gem.authors       = ['Alex Y.', 'Mehrez Alachheb']
  gem.summary       = 'REST API documentation generator'
  gem.homepage      = "https://github.com/malachheb/calamum"
  gem.license       = 'MIT'
  gem.email         = ['lachheb.mehrez@gmail.com']
  gem.files         = Dir['lib/**/*.*']
  gem.bindir        = 'bin'
  gem.executables   = 'calamum'
  gem.require_paths = ['lib']


  gem.add_dependency 'yajl-ruby'
  gem.add_dependency 'mixlib-cli'
  gem.add_dependency 'mixlib-config'
  
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 3.0.0'
  gem.add_development_dependency 'rspec-its'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rainbow',     '= 1.1.4'  
  gem.add_development_dependency 'rubocop', '~> 0.15.0'
  gem.add_development_dependency 'coveralls'

end
