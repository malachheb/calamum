
class ApiDoc::ApiDefinitionParser

  def initialize(api_definition_yaml)
    @api_definition = api_definition_yaml
  end

  def get_resources
    @api_definition.inject([]){|resources, (key, content)| resources << key}
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
