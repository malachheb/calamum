
class Calamum::DefinitionParser

  def initialize(definition_yaml)
    @api_definition = definition_yaml
  end

  def get_resources
    @api_definition.inject([]){|resources, (key, content)| resources << key}
  end
  
  def initialize_resources_requests
    resources = Hash.new
    @api_definition.each do |resource, requests|
      resources[resource] = Array.new
      requests.each_with_index do |request, index|
        attrs = {uri: request['uri'], action: request['action'], params: request['params'], description: request['description'], content_type: request['content_type']}
        resources[resource][index]= Calamum::Request.new(attrs)
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
