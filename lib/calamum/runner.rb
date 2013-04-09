require 'calamum'
require 'calamum/config'
require 'calamum/doc_generator'
require 'mixlib/cli'

class Calamum::Runner
  include Mixlib::CLI
  CMD_NAME = "calamum"

  def initialize
    super
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

  option :debug,
    :short        => "-d",
    :long         => "--debug",
    :description  => "Show actions to do (default)",
    :boolean      => true,
    :default      => true,
    :proc         => lambda { |p| true }

  option :definition,
    :short        => "-f DEFINITION",
    :long         => "--file DEFINITION",
    :description  => "Definition YAML file",
    :required => true

  option :template,
    :short        => "-t TEMPLATE",
    :long         => "--template TEMPLATE",
    :description  => "Documentation HTML template",
    :default      =>  "bootstrap"

  option :path,
    :short        => "-p PATH",
    :long         => "--path PATH",
    :description  => "The distination path for the generated doc directory",
    :default      =>  ENV['HOME']

  option :sort,
    :short        => "-s",
    :long         => "--sort",
    :description  => "Sort the resources alphabetically",
    :boolean      => true,
    :default      => false

  def run
    load_options
    Calamum::Config.merge!(config)
    api_definition = load_definition_file
    @definition = Calamum::DefinitionParser.new(api_definition)
    @definition.load_requests
    template = Calamum::DocGenerator.load_template
    html_output = Calamum::DocGenerator.new(template,
        @definition.resources, @definition.get_name, @definition.get_url, @definition.get_description)
    html_output.save_result(File.join(Calamum::Config[:path], 'doc', 'index.html'))
  end

  def load_definition_file
    begin
       YAML.load(File.open(config[:definition]))
    rescue => e
      puts_error e.message
    end
  end

  def load_options
    begin
      parse_options
    rescue => e
      puts_error e.message
    end
  end

end
