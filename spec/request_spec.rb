require 'spec_helper'

describe Calamum::Request do
  before do
    @attrs = {uri: '/users', action: 'get', params: {id:{type: 'String'}}, content_type: 'application/json'} 
  end

  specify{Calamum::Request.new(@attrs).should be_true}
  specify{Calamum::Request.new(@attrs.merge(uri:'')).errors[:uri].should == ["can't be blank"]}
  specify{Calamum::Request.new(@attrs.merge(action:'')).errors[:action].should == ["can't be blank"]}
  specify{Calamum::Request.new(@attrs.merge(action:'foo')).errors[:action].should == ["is not included in [GET POST PUT DELETE]"]}
  
end
