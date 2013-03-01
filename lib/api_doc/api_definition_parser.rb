
class ApiDoc::ApiDefinitionParser

  def initialize(api_definition_yaml)
    @api_definition = api_definition_yaml
  end

  def get_resources
    @api_definition.inject([]){|resources, (key, content)| resources << key}
  end

  def get_resource_action(resource)
     @api_definition[resource]['action']
  end

  def get_resource_uri(resource)
    @api_definition[resource]['uri']
  end

end
