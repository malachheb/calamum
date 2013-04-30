
class Calamum::DocGenerator
  include ERB::Util
  attr_accessor :resources, :template, :name, :url, :description

  def initialize(template, resources, name, url, descr)
    @template = template
    @resources = resources
    @name = name
    @url = url
    @description = descr
  end

  def render()
    ERB.new(@template).result(binding)
  end

  def self.get_template_base
    template_opt = Calamum::Config[:template]
    if template_opt.start_with?('/')
        return template_opt
    else
        return File.join(File.dirname(__FILE__), "templates", template_opt)
    end
  end

  def self.load_template
    File.read(File.join(get_template_base, "index.html.erb"))
  end
  
  def save_result(file)
    initialize_doc_dir
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end

  def initialize_doc_dir
    create_doc_dir
    Dir.mkdir File.join(Calamum::Config[:path], 'doc', 'assets')
    copy_assets
  end

  def copy_assets
    src = File.join(Calamum::DocGenerator.get_template_base, "assets")
    dst = File.join(Calamum::Config[:path], 'doc', 'assets')
    begin
      FileUtils.copy_entry(src, dst)
    rescue => e
      puts_error e.message
    end
  end

  def create_doc_dir
    doc_dir = File.join(Calamum::Config[:path], 'doc')
    if File.exist?(doc_dir)
      while true
        print "The filename directoy #{doc_dir} already exists. Do you want to overwrite it? [Y/N]: "
        case $stdin.gets.chomp!.downcase
        when 'y'
          FileUtils.rm_r(doc_dir, :force => true)
          break
        when 'n'
         exit(1) 
        end
      end
    end
    Dir.mkdir doc_dir
  end

end
