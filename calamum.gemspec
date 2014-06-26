lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'calamum/version'
Gem::Specification.new do |gem|
  gem.name          = 'calamum'
  gem.version       = Calamum::VERSION
  gem.authors       = ['Alex Y.', 'Mehrez Alachheb']
  gem.summary       = 'REST API documentation generator'
  gem.homepage      = "https://github.com/malachheb/calamum"
  gem.files         = Dir['lib/**/*.*']
  gem.bindir        = 'bin'
  gem.executables   = 'calamum'
  gem.require_paths = ['lib']

  gem.add_dependency 'yajl-ruby'
  gem.add_dependency 'mixlib-cli'
  gem.add_dependency 'mixlib-config'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec-its'
end
