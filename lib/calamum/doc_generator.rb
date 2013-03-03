
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
    File.read(File.join(File.dirname(__FILE__), "templates", "index.html.erb"))
  end
  
  def save_result(file)
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end

end
