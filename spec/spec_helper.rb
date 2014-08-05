require 'coveralls'
Coveralls.wear!

require 'rspec/its'
require_relative '../lib/calamum'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = [:should, :expect]
  end
end
