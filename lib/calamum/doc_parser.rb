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

  def get_resources
    @definition['resources']
  end

  def load_resources
    get_resources.each do |name, methods|
      list = []
      methods.each do |resource|
        if validate_resource?(resource)
          list << Calamum::Resource.new(resource)
          puts_info "#{resource['action']}: #{resource['uri']}"
        else
          puts_warning "Resource #{name} has incorrect definition"
        end
      end

      @resources[name] = list if list.any?
    end

    @resources
  end

  def validate_resource?(resource)
    resource['uri'] && resource['action'] && resource['description']
  end

end
