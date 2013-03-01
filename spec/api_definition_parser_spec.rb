require 'spec_helper'

describe ApiDoc::ApiDefinitionParser do
  before do
    api_definition = YAML.load(File.open("spec/data/my_api_definition.yml"))
    @definition = ApiDoc::ApiDefinitionParser.new(api_definition)
  end

  specify{@definition.get_resources.should == ['user', 'group']}
  specify {@definition.get_resource_action('user').should == 'get'}
  specify{@definition.get_resource_uri('user').should == 'test'}

end
