
class Calamum::DocGenerator
  include ERB::Util
  attr_accessor :resources, :templaete

  def initialize(template, resources)
    @template = template
    @resources = resources
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
    src = File.join(File.dirname(__FILE__), "templates", "bootstrap", "assets")
    dst = File.join(ENV['HOME'], 'doc', 'assets')
    FileUtils.copy_entry(src, dst)
  end

end
