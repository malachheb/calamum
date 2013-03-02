
class Calamum::DocGenerator
  include ERB::Util
  attr_accessor :resources, :template, :date

  def initialize(template)
    @template = template
  end
xf
  def render()
    ERB.new(@template).result(binding)
  end

  def save_result(file)
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end

end
