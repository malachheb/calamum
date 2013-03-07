require 'spec_helper'

describe Calamum::DefinitionParser do
  before do
    definition = YAML.load(File.open("spec/data/my_definition.yml"))
    @api_definition = Calamum::DefinitionParser.new(definition)
    @api_definition.load_requests
  end

  specify{@api_definition.get_resources_names.should == ['user', 'group']}
  specify{@api_definition.get_resource_uris('user').size.should == 2}
  specify{@api_definition.resources['user'].size.should == 2}
  specify{@api_definition.resources['user'][0].errors.should be_empty}
  specify{@api_definition.resources['user'][0].action.should == 'GET'}
  specify{@api_definition.resources['user'][0].uri.should == '/users'}
  specify{@api_definition.resources['user'][0].content_type.should == 'application/json'}
end
