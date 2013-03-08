class Calamum::DefinitionParser
  attr_accessor :definition, :resources

  def initialize(definition_yaml)
    @definition = definition_yaml
    @resources = Hash.new
  end

  def get_resources
    @definition['resources']
  end

  def get_name
    @definition['name']
  end

  def get_url
    @definition['url']
  end

  def get_resources_names
    @definition['resources'].inject([]){|resources, (key, content)| resources << key}
  end

  def load_requests
    self.get_resources.each do |resource, requests|
      @resources[resource] = []
      index = 0
      requests.each do |request|
        req = initialize_request(request)
        unless req.nil?
          @resources[resource][index]= req
          index += 1
        end
      end
    end
    @resources
  end

  def initialize_request(request)
    req = Calamum::Request.new({
                                 :uri =>  request['uri'],
                                 :action => request['action'],
                                 :params => request['params'],
                                 :description => request['description'],
                                 :headers => request['headers'],
                                 :response => request['response'],
                               })
    if req.errors.empty?
      $stderr.puts "[INFO] Request #{request['action']}: #{request['uri']} loading success"
      req
    else
      $stderr.puts "[ERROR] Request #{request['action']}: #{request['uri']} not valid: #{req.errors}"
      nil
    end
  end

  def get_resource_uris(name)
    @resources[name]
  end

  def find_resource_uri_by_label(resource, label)
    @resources.select{|r| r['label']==label}.first['uri']
  end

  def find_resource_action_by_label(resource, label)
    @resources.select{|r| r['label']==label}.first['action']
  end

end
