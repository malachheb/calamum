require 'spec_helper'

describe Calamum::DefinitionParser do
  before do
    definition = YAML.load(File.open("spec/data/my_definition.yml"))
    @definition = Calamum::DefinitionParser.new(definition)
  end

  specify{@definition.get_resources.should == ['user', 'group']}
  specify {@definition.get_resource_uris('user').size.should == 2}
  specify{@definition.initialize_resources_requests['user'].size.should == 2}
  specify{@definition.initialize_resources_requests['user'][0].errors.should be_empty}
  specify{@definition.initialize_resources_requests['user'][0].action.should == 'GET'}
  specify{@definition.initialize_resources_requests['user'][0].uri.should == '/users'}
  specify{@definition.initialize_resources_requests['user'][0].content_type.should == 'application/json'}  
end
