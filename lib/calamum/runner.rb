#require 'api_doc/application'
#require 'home5k/user'
#require 'home5k/misc'
#require 'restclient'
#require 'json/pure'
#require 'uri'
#require 'progressbar'
#require 'facter'
require 'calamum'
require 'calamum/config'
require 'calamum/doc_generator'
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
    :short        => "-d DEFINITION",
    :long         => "--definition DEFINITION",
    :description  => "Definition YAML file",
    :required => true

  option :template,
    :short        => "-t TEMPLATE",
    :long         => "--template TEMPLATE",
    :description  => "Documentation HTML template"

  def run
    parse_options
    Calamum::Config.merge!(config)
    api_definition = YAML.load(File.open(config[:definition]))
    @definition = Calamum::DefinitionParser.new(api_definition)
    @definition.load_requests
    template = Calamum::DocGenerator.load_template
    html_output = Calamum::DocGenerator.new(template, @definition.resources, @definition.get_name, @definition.get_url)
    html_output.save_result(File.join(ENV['HOME'], 'doc', 'index.html'))
  end

end
