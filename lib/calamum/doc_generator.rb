class Calamum::DocGenerator
  attr_accessor :template

  def initialize(tpl_name)
    tpl_path = Calamum::Config[:tpl_path]
    filename = "#{tpl_path}/#{tpl_name}.html.erb"

    @template = ERB.new(File.read(filename))
  end

  def self.init_base_dir
    tpl_path = Calamum::Config[:tpl_path]
    doc_path = Calamum::Config[:doc_path]
    FileUtils.rm_r(doc_path, :force => true)
    Dir.mkdir(doc_path)

    # copy assets from template directory
    source = File.join(tpl_path, 'assets')
    target = File.join(doc_path, 'assets')
    FileUtils.copy_entry(source, target)
  end

  def save_template(filename, values)
    values.each do |k, v|
      instance_variable_set("@#{k}", v)
    end

    html_data = @template.result(binding)
    filename = File.join(Calamum::Config[:doc_path], filename)
    File.open(filename, 'w+') { |file| file.write(html_data) }
  end

end
