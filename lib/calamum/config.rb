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
    self.tpl_path = File.join(config[:tplpath], config[:template])

    unless File.exist?(self.tpl_path)
      fail "Cannot find template #{config[:template]}"
    end
  end
end
