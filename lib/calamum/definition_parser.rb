
class Calamum::DefinitionParser

  def initialize(definition_yaml)
    @api_definition = definition_yaml
  end

  def get_resources
    @api_definition['resources']
  end

  def get_resources_names
    @api_definition['resources'].inject([]){|resources, (key, content)| resources << key}
  end
  
  def initialize_resources_requests
    resources = Hash.new
    get_resources.each do |resource, requests|
      resources[resource] = Array.new
      $stdout.puts "[INFO] Resource #{resource}"
      requests.each_with_index do |request, index|
        req = Calamum::Request.new({uri: request['uri'], action: request['action'], params: request['params'], description: request['description'], content_type: request['content_type']})
        if req.valid?
          $stdout.puts "  [INFO] Request '#{req}' load success"
          resources[resource][index]= req
        else
          $stderr.puts "  [ERROR] Request '#{req}' load failed, #{req.errors}"
        end
      end
    end
    resources
  end

  def get_resource_uris(resource)
     @api_definition[resource]
  end

  def find_resource_uri_by_label(resource, label)
    @api_definition[resource].select{|r| r['label']==label}.first['uri']
  end

  def find_resource_action_by_label(resource, label)
    @api_definition[resource].select{|r| r['label']==label}.first['action']
  end

end
