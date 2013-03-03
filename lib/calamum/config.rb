require 'calamum'
require 'mixlib/config'

module Calamum
  class Config
    extend Mixlib::Config

    def self.inspect
      configuration.inspect
    end

  end 
end
