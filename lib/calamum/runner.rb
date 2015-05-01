require 'calamum'
require 'calamum/config'
require 'calamum/doc_generator'
require 'mixlib/cli'

# Provides a class-based command line opts.
# See https://github.com/opscode/mixlib-cli
class Calamum::Runner
  include Mixlib::CLI

  option :help,
    :short        => '-h',
    :long         => '--help',
    :description  => 'Show this help',
    :on           => :tail,
    :boolean      => true,
    :show_options => true,
    :exit         => 0

  option :source,
    :short        => '-f DEFINITION',
    :long         => '--file DEFINITION',
    :description  => 'Path to the file with JSON API definition',
    :required     => true

  option :template,
    :short        => '-t TEMPLATE',
    :long         => '--template TEMPLATE',
    :description  => 'Name of HTML template [twitter, bootstrap](twitter by default)',
    :default      => 'twitter'

  option :path,
    :short        => '-p PATH',
    :long         => '--path PATH',
    :description  => 'Path to the directory where docs will be generated',
    :default      => ENV['HOME']

  option :debug,
    :short        => '-d',
    :long         => '--debug',
    :description  => 'Show actions to do (true by default)',
    :default      => true,
    :boolean      => true,
    :proc         => lambda { |x| true }

  option :version,
    :short        => '-v',
    :long         => '--version',
    :description  => 'Show version number',
    :proc         => lambda { |x| puts Calamum::VERSION },
    :exit         => 0

  option :sort,
    :short        => "-s",
    :long         => "--sort",
    :description  => "Sort the resources alphabetically",
    :boolean      => true,
    :default      => false

  # Parses command line options and generates API documentation.
  # See samples for details how to define meta-data for your API.
  def run
    parse_options
    Calamum::Config.apply(config)
    @definition = Calamum::DocParser.new(load_source)
    @definition.load_resources
    Calamum::DocGenerator.init_base_dir
    process_index

    if config[:template] == 'twitter'
      process_pages
      process_section("overview",  @definition.get_description)
      process_section("authentication", @definition.get_authentication)
      process_errors
    end
  rescue => ex
    puts_error ex.message
  end

  # Open and load the source file of api definition
  def load_source
    case File.extname(config[:source])
    when '.json'
      Yajl.load(File.open(config[:source]))
    when '.yml'
      YAML.load(File.open(config[:source]))
    else
      raise 'unknown source file extension'
    end
  end

  # Bind values to index page and save it.
  def process_index
    bindings = {
      :url => @definition.get_url,
      :name => @definition.get_name,
      :resources => @definition.resources,
      :description => @definition.get_description,
      :version => @definition.get_version,
      :copyright => @definition.get_copyright
    }

    page = Calamum::DocGenerator.new(:index)
    page.save_template('index.html', bindings)
  end

  # Bind values to overview and authentication pages and save them.
  def process_section(section, content)
    bindings = {
      :section => section,
      :name => @definition.get_name,
      :version => @definition.get_version,
      :description => content,
      :copyright => @definition.get_copyright
    }
    page = Calamum::DocGenerator.new(:section)
    page.save_template("#{section}.html", bindings)
  end

  def process_errors
    bindings = {
      :name => @definition.get_name,
      :version => @definition.get_version,
      :errors => @definition.get_errors,
    }
    page = Calamum::DocGenerator.new(:errors)
    page.save_template("errors.html", bindings)
  end

  # Bind values to view pages and save them.
  def process_pages
    bindings = {
      :name => @definition.get_name,
      :version => @definition.get_version
    }

    page = Calamum::DocGenerator.new(:view)
    @definition.resources.each do |methods|
      methods[1].each do |resource|
        bindings.merge!(:resource => resource)
        filename = "#{resource.slug}.html"
        page.save_template(filename, bindings)
      end
    end
  end

end
