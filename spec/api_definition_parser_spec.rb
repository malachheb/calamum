require 'spec_helper'

describe ApiDoc::ApiDefinitionParser do
  before do
    api_definition = YAML.load(File.open("spec/data/my_api_definition.yml"))
    @definition = ApiDoc::ApiDefinitionParser.new(api_definition)
  end

  specify{@definition.get_resources.should == ['user', 'group']}
  specify {@definition.get_resource_uris('user').size.should == 2}
  specify{@definition.find_resource_uri_by_label('user', 'get_user').should == 'test'}
  specify{@definition.find_resource_action_by_label('user', 'get_user').should == 'get'}

end
