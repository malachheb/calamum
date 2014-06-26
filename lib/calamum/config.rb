# require 'calamum'
require 'mixlib/config'

# Provides a class-based configuration object.
# See https://github.com/opscode/mixlib-config
class Calamum::Config
  extend Mixlib::Config

  def self.inspect
    configuration.inspect
  end

  def self.apply(config)
    merge!(config)

    self.doc_path = File.join(config[:path], 'docs')
    self.tpl_path = File.join(File.dirname(__FILE__), 'templates', config[:template])
    raise "Unknown template #{config[:template]}" unless Calamum::VALID_TEMPLATES.include?(config[:template])
  end

end
