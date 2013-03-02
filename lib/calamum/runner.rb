#require 'api_doc/application'
#require 'home5k/config'
#require 'home5k/user'
#require 'home5k/misc'
#require 'restclient'
#require 'json/pure'
#require 'uri'
#require 'progressbar'
#require 'facter'
require 'calamum'
require 'mixlib/cli'

class Calamum::Runner
  include Mixlib::CLI
  CMD_NAME = "calamum"

  def initialize  
    super
    
    # trap("TERM") do
    #   Home5k::Application.fatal!("SIGTERM received, stopping", 1)
    # end
    
    # trap("INT") do
    #   Home5k::Application.fatal!("SIGINT received, stopping", 2)
    # end
  end
  
  def run
    parse_options
  end
  
  option :help,
    :short        => "-h",
    :long         => "--help",
    :description  => "Show this message",
    :on           => :tail,
    :boolean      => true,
    :show_options => true,
    :exit         => 0
  
  option :version,
    :short        => "-v",
    :long         => "--version",
    :description  => "Show #{CMD_NAME} version",
    :boolean      => true,
    :proc         => lambda {|v| puts "Calamum: #{Calamum::VERSION}"},
    :exit         => 0
  
  option :dryrun,
    :long         => "--dryrun",
    :description  => "Show actions to do (default)",
    :boolean      => true,
    :default      => true,
    :proc         => lambda { |p| true }
    
  option :definition,
    :short        => "-d",
    :long         => "--definition",
    :description  => "Definition YAML file",
    :boolean      => true,
    :default      => false
    
  option :template,
    :short        => "-t",
    :long         => "--template",
    :description  => "Documentation HTML template"
end
