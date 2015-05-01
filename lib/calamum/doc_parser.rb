class Calamum::DocParser
  attr_accessor :resources, :definition

  def initialize(definition)
    @resources = Hash.new
    @definition = definition
  end

  def get_url
    @definition['url']
  end

  def get_name
    @definition['name']
  end

  def get_version
    @definition['version']
  end

  def get_copyright
    @definition['copyright']
  end

  def get_authentication
    @definition['authentication']
  end

  def get_description
    @definition['description']
  end

  def get_errors
    @definition['errors']
  end

  def get_resources
    resources = @definition['resources'].kind_of?(String) ? get_seperate_resources : @definition['resources']
    Calamum::Config[:sort]? resources.sort : resources
  end

  def get_seperate_resources
    extension = File.extname(Calamum::Config[:source])
    path = File.expand_path("#{@definition['resources']}", File.dirname(Calamum::Config[:source]))
    case extension
    when '.json' then Dir["#{path}/*#{extension}"].map { |f| Yajl.load File.read(f) }.flatten.reduce({}, :merge)
    when '.yml' then Dir["#{path}/*#{extension}"].map { |f| YAML.load File.read(f) }.flatten.reduce({}, :merge)
    else raise 'unknown source file extension'
    end
  end

  def load_resources
    get_resources.each do |name, methods|
      list = []
      methods.each do |resource|
        if validate_resource?(resource)
          list << Calamum::Resource.new(resource)
          puts_info "#{resource['action']}: #{resource['uri']}"
        else
          puts_warning "Resource #{resource['action']}: #{resource['uri']} has incorrect definition"
        end
      end
      @resources[name] = list if list.any?
    end
    @resources
  end

  def validate_resource?(resource)
    resource['uri'] && resource['action'] && resource['description'] && %{GET POST PUT DELETE}.include?(resource['action'].upcase)
  end

end
