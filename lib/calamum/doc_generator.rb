
class Calamum::DocGenerator
  include ERB::Util
  attr_accessor :resources, :templaete, :name, :url

  def initialize(template, resources, name, url)
    @template = template
    @resources = resources
    @name = name
    @url = url
  end

  def render()
    ERB.new(@template).result(binding)
  end

  def self.load_template
    File.read(File.join(File.dirname(__FILE__), "templates", "bootstrap", "index.html.erb"))
  end
  
  def save_result(file)
    initialize_doc_dir
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end

  def initialize_doc_dir
    FileUtils.rm_r(File.join(ENV['HOME'], 'doc'), :force => true)
    Dir.mkdir File.join(ENV['HOME'], 'doc')
    Dir.mkdir File.join(ENV['HOME'], 'doc', 'assets')
    copy_assets
  end

  def copy_assets
    src = File.join(File.dirname(__FILE__), "templates", Calamum::Config[:template], "assets")
    dst = File.join(ENV['HOME'], 'doc', 'assets')
    begin
      FileUtils.copy_entry(src, dst)
    rescue => e
      puts_error e.message
    end
  end

end
