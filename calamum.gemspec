lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'calamum/version'

Gem::Specification.new do |gem|
  gem.name          = "calamum"
  gem.version       = Calamum::VERSION
  gem.authors       = ["Mehrez Alachheb"]
  gem.email         = ["lachheb.mehrez@gmail.com"]
  gem.description   = %q{Calamum is a simple ruby build program to generate a REST API documentation from a YAML file definition}
  gem.summary       = %q{Calamum is a simple ruby build program to generate a REST API documentation from a YAML file definition}
  gem.homepage      = "https://github.com/malachheb/liblvm"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.bindir            = "bin"

  gem.add_dependency 'activemodel'
  gem.add_dependency 'mixlib-cli'
  gem.add_dependency 'mixlib-config'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
end