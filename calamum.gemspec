lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_doc/version'

Gem::Specification.new do |gem|
  gem.name          = "calamum"
  gem.version       = Calamum::VERSION
  gem.authors       = ["Mehrez Alachheb"]
  gem.email         = ["lachheb.mehrez@gmail.com"]
  gem.description   = %q{provides a framework to generate a rest api documentaion}
  gem.summary       = %q{provides a framework to generate a rest api documentaion}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'	
  gem.add_development_dependency 'active_support'
end